Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11B420575
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnEk0Odz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgDUXnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgDUXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:43:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E7C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 16:43:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so129469pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dWfsRVTuFNNjBGMemQwi7sQKXBXQtuxZZf/HtreNbYQ=;
        b=cnEk0OdzMp63ug1HuGxboADJAIhe57fpJ1D2ylYVfTF1Z2JUFKeaCUr/zwAKB7Gl/m
         B+OVdlwxqtH/k8Bum4Bw780zm2UWir9GTEYMeC4Tl1Hfa0ARx2BztowH9Gj0mgAOfUXL
         Y9ByXnOy7clQ7Ak7x1Oyp8Lz0laWrHMtOXndU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dWfsRVTuFNNjBGMemQwi7sQKXBXQtuxZZf/HtreNbYQ=;
        b=RCIxT9Pzmzu49srrGvWSySFHT0kQAoYWu8h2aK8TYNtZB2OCyhi2waXsLbbmOnQ4Ew
         sit8QkXt6sVb0J2l83QIw7WZtAvbj6gdh1UjXBpv9XA11TbsqTuexxxPcnpCFZ8xby9R
         fnybUXhVCHmqAKnciBDM+nJtRPKxseXwyAUznhIMZiGEEqXtJoggc1CgJMn6AcRWxGoH
         zbNfZ0+bNZsixg7m4h6sxjw3NsoVpH+3MiJ84qOE6UKqgMtxA1UQHvvkj2+sXiDgVosV
         W8Hytneomq6i0pIIKaLKIASdh6gAVCYQeYcREF3kpCXgAiRWnywzKU/k2R9gH677rHEL
         kqhg==
X-Gm-Message-State: AGi0PuZ7zODkxL+6phVWPROoRh3fHRgCHq5ziOo85h6MXMPMAuROB8rf
        tfMVf5Ygfi99UARIzG1u4SWjAw==
X-Google-Smtp-Source: APiQypKWHPAm3XE4Zk5H/T8Idvm9C2drvlscLSeam/+ng3soZpkb+qAmXJ9yEyDJSsBzP7CPTgAg8g==
X-Received: by 2002:a62:1c8b:: with SMTP id c133mr25393676pfc.242.1587512626987;
        Tue, 21 Apr 2020 16:43:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i190sm3461003pfe.114.2020.04.21.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 16:43:46 -0700 (PDT)
Date:   Tue, 21 Apr 2020 16:43:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] objtool: optimize add_dead_ends for split sections
Message-ID: <202004211643.CACC511DD@keescook>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421220843.188260-1-samitolvanen@google.com>
 <20200421220843.188260-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421220843.188260-3-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:08:43PM -0700, Sami Tolvanen wrote:
> Instead of iterating through all instructions to find the last
> instruction each time .rela.discard.(un)reachable points beyond the
> section, use find_insn to locate the last instruction by looking at
> the last bytes of the section instead.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/objtool/check.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 4b170fd08a28..4f1d405420a4 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -303,6 +303,19 @@ static int decode_instructions(struct objtool_file *file)
>  	return ret;
>  }
>  
> +static struct instruction *find_last_insn(struct objtool_file *file,
> +					  struct section *sec)
> +{
> +	struct instruction *insn = NULL;
> +	unsigned int offset;
> +	unsigned int end = (sec->len > 10) ? sec->len - 10 : 0;
> +
> +	for (offset = sec->len - 1; offset >= end && !insn; offset--)
> +		insn = find_insn(file, sec, offset);
> +
> +	return insn;
> +}
> +
>  /*
>   * Mark "ud2" instructions and manually annotated dead ends.
>   */
> @@ -311,7 +324,6 @@ static int add_dead_ends(struct objtool_file *file)
>  	struct section *sec;
>  	struct rela *rela;
>  	struct instruction *insn;
> -	bool found;
>  
>  	/*
>  	 * By default, "ud2" is a dead end unless otherwise annotated, because
> @@ -337,15 +349,8 @@ static int add_dead_ends(struct objtool_file *file)
>  		if (insn)
>  			insn = list_prev_entry(insn, list);
>  		else if (rela->addend == rela->sym->sec->len) {
> -			found = false;
> -			list_for_each_entry_reverse(insn, &file->insn_list, list) {
> -				if (insn->sec == rela->sym->sec) {
> -					found = true;
> -					break;
> -				}
> -			}
> -
> -			if (!found) {
> +			insn = find_last_insn(file, rela->sym->sec);
> +			if (!insn) {
>  				WARN("can't find unreachable insn at %s+0x%x",
>  				     rela->sym->sec->name, rela->addend);
>  				return -1;
> @@ -379,15 +384,8 @@ static int add_dead_ends(struct objtool_file *file)
>  		if (insn)
>  			insn = list_prev_entry(insn, list);
>  		else if (rela->addend == rela->sym->sec->len) {
> -			found = false;
> -			list_for_each_entry_reverse(insn, &file->insn_list, list) {
> -				if (insn->sec == rela->sym->sec) {
> -					found = true;
> -					break;
> -				}
> -			}
> -
> -			if (!found) {
> +			insn = find_last_insn(file, rela->sym->sec);
> +			if (!insn) {
>  				WARN("can't find reachable insn at %s+0x%x",
>  				     rela->sym->sec->name, rela->addend);
>  				return -1;
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

-- 
Kees Cook
