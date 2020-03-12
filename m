Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC95C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AF720737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPcPXBcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCLKw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:52:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37250 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgCLKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584010377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qh0eXeonMgy20ck7YawIUlc8xJ7ukIA09ot5F0zPtg4=;
        b=BPcPXBcXMDiLhTIirLez1u3855R0hn2v5Z8En8r7jqz/Gm6tbCvSu8c3hb/DyccNcY0d2F
        IARAID12KJdc49dJeTdm85O7SSiCffg2zpxu3B0HuxAWm1PzKDw8wBezJF4pmbnP94CHpt
        I7qmJxIxZbnbKRUnZYX5Nzsgam6T5do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-KYVpkvHxM6yhQfbW7eF_NQ-1; Thu, 12 Mar 2020 06:52:55 -0400
X-MC-Unique: KYVpkvHxM6yhQfbW7eF_NQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8FA3800D5B;
        Thu, 12 Mar 2020 10:52:52 +0000 (UTC)
Received: from krava (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C307388;
        Thu, 12 Mar 2020 10:52:44 +0000 (UTC)
Date:   Thu, 12 Mar 2020 11:52:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200312105231.GE311223@krava>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309062552.29911-7-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309062552.29911-7-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:55:50AM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 9377538f4097..d17664e628db 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -15,6 +15,7 @@ struct parse_ctx {
>  	struct parse_id ids[MAX_PARSE_ID];
>  };
>  
> +int expr__runtimeparam;
>  void expr__ctx_init(struct parse_ctx *ctx);
>  void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
>  int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr);
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 1928f2a3dddc..ec4b00671f67 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -45,6 +45,21 @@ static char *normalize(char *str)
>  			*dst++ = '/';
>  		else if (*str == '\\')
>  			*dst++ = *++str;
> +        else if (*str == '?') {
> +
> +			int size = snprintf(NULL, 0, "%d", expr__runtimeparam);
> +			char * paramval = (char *)malloc(size);

can't we agree that any reasonable number in here
wouldn't cross 20 bytes in string or so and use
buffer for that instead of that malloc exercise?

thanks,
jirka

> +			int i = 0;
> +
> +			if(!paramval)
> +				*dst++ = '0';
> +			else {
> +				sprintf(paramval, "%d", expr__runtimeparam);
> +				while(i < size)
> +					*dst++ = paramval[i++];
> +				free(paramval);
> +			}
> +		}

SNIP

