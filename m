Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7FAC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2A621582
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579298694;
	bh=ec1O7egKn0cduWWf5vzCmil8ePkqut6YAK6KdPx2npo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=Pe8yo7rcdVaNjfhG9bCVXfyFV2JoYFDIn35rQQowsGGzB8FRCymiNJCAAR6G2SV1D
	 T2Rnw7Cr8A9AhrcjbmaXmWlo4t/79eB2R4Pogz1EKUb6CHwtz2GX9BK9yRDDrXfVIm
	 dfnPfa0Yonr4cdBdo0zMTVlqWLRxKsn/SnUTMzQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgAQWEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgAQWEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:04:53 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92C620748;
        Fri, 17 Jan 2020 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579298692;
        bh=ec1O7egKn0cduWWf5vzCmil8ePkqut6YAK6KdPx2npo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FQdHl2O10HrtTushfop9FCpbpDKM3TVun3w2BJFDPsyH8wVeYKwl1a01v/858k4Lx
         0xfNGsXyOCLKCn+imeFjfkkEVslfzjZpwN7TLCnJGuwE1be3mK6wce1h4jqviLuTKo
         FZdgxfa8yABGmINobhqsnOHaAeRatPajs4yPNrJw=
Message-ID: <1579298690.4518.15.camel@kernel.org>
Subject: Re: Unresolved reference for histogram variable
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jan 2020 16:04:50 -0600
In-Reply-To: <20200116165658.4e8d15fb@gandalf.local.home>
References: <20200116154216.58ca08eb@gandalf.local.home>
         <20200116165658.4e8d15fb@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2020-01-16 at 16:56 -0500, Steven Rostedt wrote:
> On Thu, 16 Jan 2020 15:42:16 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > in parse_expr():
> > 
> > 	operand1->read_once = true;
> > 	operand2->read_once = true;
> > 
> > Why is that?
> > 
> > This means that any variable used in an expression can not be use
> > later
> > on.
> > 
> > Or should the variable be detected that it is used multiple times
> > in
> > the expression, and have the parser detect this, and just reuse the
> > same variable multiple times?
> 
> This patch seems to fix the problem, and lets us reuse the same
> variable multiple times.
> 

I tested this patch after removing the checks for size and is_signed,
which aren't needed because just the var.idx and hist_data is enough to
know you're referencing the same variable.

So removing these lines: 

		    ref_field->size == var_field->size &&
		    ref_field->is_signed == var_field->is_signed) {

passed selftests and the specific failure you found.

Just to clarify some more about what the problem was is that without
your patch, we would have two separate references to the same variable,
and during resolve_var_refs(), they'd both want to be resolved
separately, so in this case, since the first reference to start wasn't
part of an expression, it wouldn't get the read-once flag set, so would
be read normally, and then the second reference would do the read-once
read and also be read but using read-once.  So everything worked and
you didn't see a problem: 

 from: start2=$start,delta=common_timestamp-$start

In the second case, when you switched them around, the first reference
would be resolved by doing the read-once, and following that the second
reference would try to resolve and see that the variable had already
been read, so failed as unset, which caused it to short-circuit out and
not do the trigger action to generate the synthetic event:

 to: delta=common_timestamp-$start,start2=$start

With your patch, we only have the single resolution which happens
correctly the one time it's resolved, so this can't happen.

Anyway, here's my reviewed and tested-by:

Reviewed-by: Tom Zanuss <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom



> -- Steve
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 117a1202a6b9..b7f944735a4a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -116,6 +116,7 @@ struct hist_field {
>  	struct ftrace_event_field	*field;
>  	unsigned long			flags;
>  	hist_field_fn_t			fn;
> +	unsigned int			ref;
>  	unsigned int			size;
>  	unsigned int			offset;
>  	unsigned int                    is_signed;
> @@ -2432,8 +2433,16 @@ static int contains_operator(char *str)
>  	return field_op;
>  }
>  
> +static void get_hist_field(struct hist_field *hist_field)
> +{
> +	hist_field->ref++;
> +}
> +
>  static void __destroy_hist_field(struct hist_field *hist_field)
>  {
> +	if (--hist_field->ref > 1)
> +		return;
> +
>  	kfree(hist_field->var.name);
>  	kfree(hist_field->name);
>  	kfree(hist_field->type);
> @@ -2475,6 +2484,8 @@ static struct hist_field
> *create_hist_field(struct hist_trigger_data *hist_data,
>  	if (!hist_field)
>  		return NULL;
>  
> +	hist_field->ref = 1;
> +
>  	hist_field->hist_data = hist_data;
>  
>  	if (flags & HIST_FIELD_FL_EXPR || flags &
> HIST_FIELD_FL_ALIAS)
> @@ -2670,6 +2681,19 @@ static struct hist_field
> *create_var_ref(struct hist_trigger_data *hist_data,
>  {
>  	unsigned long flags = HIST_FIELD_FL_VAR_REF;
>  	struct hist_field *ref_field;
> +	int i;
> +
> +	for (i = 0; i < hist_data->n_var_refs; i++) {
> +		ref_field = hist_data->var_refs[i];
> +		/* Maybe this is overkill? */
> +		if (ref_field->var.idx == var_field->var.idx &&
> +		    ref_field->var.hist_data == var_field->hist_data 
> &&
> +		    ref_field->size == var_field->size &&
> +		    ref_field->is_signed == var_field->is_signed) {
> +			get_hist_field(ref_field);
> +			return ref_field;
> +		}
> +	}
>  
>  	ref_field = create_hist_field(var_field->hist_data, NULL,
> flags, NULL);
>  	if (ref_field) {
