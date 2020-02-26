Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC5C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2121927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ent5dnpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgBZDxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:53:47 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41299 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgBZDxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:53:47 -0500
Received: by mail-yw1-f66.google.com with SMTP id l22so1862846ywc.8;
        Tue, 25 Feb 2020 19:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=exTa4V5GT58+3zXWxZHPQae7jPzZ97tMG3gr3P5XvQo=;
        b=ent5dnpkhIONW4+hFnA6fcEibNW0RC5xdbTbqNvOc/wpujsZnK2j+Aujr798Na7+1E
         GRTLSyTggVio39H9XH2t1zfCE0ux0sau00Ln0ykDWJjQm9/xri/aZUG+Ug9aEmmjW6cp
         PwHp0YE0oOWSTaKsDWEoabJTSI/5EqcEaDJjLuh5ou8a+GelJGupXRIMXEXY28xEVN+R
         TqZ/GqDklP/76V3GLpy78BAQTEhMRAZb7nz8artxCr99SGm+rmJMcEhjmE2b/q/B6N4k
         RMfamEXPMlnfSsxsJuioCQJ8ZhJWM30hTksZpMSONuUX5N6nTnXg5hpV6UTqyDyXaEPH
         /amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=exTa4V5GT58+3zXWxZHPQae7jPzZ97tMG3gr3P5XvQo=;
        b=ZszfkdvrRsCrt51hFZZlTMfREZk8VhUmp2kcXD9fN/A9ekIyVUme8J0Qw17TKLMb+/
         f6aVResJKdecYqPt4Pzjaf3b1GqN8qxEbkHbfiAuenHKM456tMuie3PMZaq1nM+rrUQ+
         ErlpNJ3XAjJeHK4a12Yrz96EuSy/t56DdtSWKnd2Mi6EvrbCg3xZjIdejXxla7P29YsW
         0DBSsRWkmzdJeQFZcjj9BrMmlPrNlRpIM8Q1JM3Olr7CN7PmqX91DD1HUf1awlOOo6W3
         VH7r1C/J+1iW48UIoNjDIgB0OwPks2ajwma4Y1m2733CC/donK6t6RLT+P/ii//DS8fn
         6jSA==
X-Gm-Message-State: APjAAAXgNNhrqcftdm/eRw9TRc66vlhERBWMfvFEk+wy5qhYwh+MITR1
        QMu94aLCKY1AIs6QW50IkGQ=
X-Google-Smtp-Source: APXvYqxT3IY1l3lBhJM0K0zYKZpVpCSmM6Wu0GrQ+TKgAgdVO8v5WhL+KvOW4O9/vtGeFF+MWdPsmQ==
X-Received: by 2002:a25:4f42:: with SMTP id d63mr2782165ybb.236.1582689226074;
        Tue, 25 Feb 2020 19:53:46 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id w15sm397709ywg.1.2020.02.25.19.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 19:53:45 -0800 (PST)
Subject: Re: [PATCH v2] of: overlay: log the error cause on resolver failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200225164540.4520-1-luca@lucaceresoli.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f9565679-5892-bcf0-f751-bfcac87670a8@gmail.com>
Date:   Tue, 25 Feb 2020 21:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225164540.4520-1-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 10:45 AM, Luca Ceresoli wrote:
> For some of its error paths, of_resolve_phandles() only logs a very generic
> error which does not help much in finding the origin of the problem:
> 
>   OF: resolver: overlay phandle fixup failed: -22
> 
> Add error messages for all the error paths that don't have one. Now a
> specific message is always emitted, thus also remove the generic catch-all
> message emitted before returning.
> 
> For example, in case a DT overlay has a fixup node that is not present in
> the base DT __symbols__, this error is now logged:
> 
>   OF: resolver: node gpio9 not found in base DT, fixup failed
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> 
> I don't know in detail the meaning of the adjust_local_phandle_references()
> and update_usages_of_a_phandle_reference() error paths, thus I have put
> pretty generic messages. Any suggestion on better wording would be welcome.

If you have not read the code to understand what the meaning of
the errors are, you should not be suggesting changes to the error
messages.

Only one of the issues detected as errors can possibly be something
other than an error either in the resolver.c code or the dtc
compiler -- a missing symbol in the live devicetree.  This may
be because of failing to compile the base devicetree without
symbols, depending on a symbol from another overlay where the
other overlay has not been applied, or depending on a symbol
from another overlay where the other overlay is applied but
the overlay was not compiled with symbols.  (Not meant to be
an exhaustive list, but it might be.)  Thus the missing
symbol problem might be fixable without a fix to kernel
code.  The error message philosophy for overlay related
errors is to minimize error messages that help diagnose
the precise cause of a kernel code bug, with the intent
of keeping the code more compact and readable.  When a
bug occurs, debugging messages can be added for the
debug session.

Following this philosophy, only the message in the second
patch chunk is ok.  I will include an example of more
precise error messages in the other locations, just for
education on what is going wrong at those points.


> 
> Changed in v2:
> 
>  - add a message for each error path that does not have one yet
> ---
>  drivers/of/resolver.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index 83c766233181..a80d673621bc 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -291,8 +291,10 @@ int of_resolve_phandles(struct device_node *overlay)
>  			break;
>  
>  	err = adjust_local_phandle_references(local_fixups, overlay, phandle_delta);
> -	if (err)
> +	if (err) {
> +		pr_err("cannot adjust local phandle references\n");
>  		goto out;
> +	}

Delete this message.  But if there was a message, it could be:

"invalid overlay, adjust local phandle references failed\n"


>  
>  	overlay_fixups = NULL;
>  
> @@ -321,11 +323,15 @@ int of_resolve_phandles(struct device_node *overlay)
>  
>  		err = of_property_read_string(tree_symbols,
>  				prop->name, &refpath);
> -		if (err)
> +		if (err) {
> +			pr_err("node %s not found in base DT, fixup failed\n",
> +			       prop->name);

"symbol '%s' not found in live devicetree symbols table\n",
       prop->name


>  			goto out;
> +		}
>  
>  		refnode = of_find_node_by_path(refpath);
>  		if (!refnode) {
> +			pr_err("cannot find node for %s\n", refpath);
>  			err = -ENOENT;
>  			goto out;
>  		}
> @@ -334,13 +340,14 @@ int of_resolve_phandles(struct device_node *overlay)
>  		of_node_put(refnode);
>  
>  		err = update_usages_of_a_phandle_reference(overlay, prop, phandle);
> -		if (err)
> +		if (err) {
> +			pr_err("cannot update usages of a phandle reference (%s)\n",
> +				prop->name);
>  			break;
> +		}

Delete this message.  But if there was a message, it could be:

"invalid fixup for symbol '%s'\n", prop->name


>  	}
>  
>  out:
> -	if (err)
> -		pr_err("overlay phandle fixup failed: %d\n", err);

Do not remove this message.  The other messages do not explain that phandle fixup
failed - they provide a more detailed description of a specific reason _why_ the
phandle fixup failed.


>  	of_node_put(tree_symbols);
>  
>  	return err;
> 

