Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A4BC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC99207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Er60HReN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgATIE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:04:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39289 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgATIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:04:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so13656311wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=17kpobL9pe7DY0967paYNJ+En7t5oWpJIpEYf5k48PQ=;
        b=Er60HReN8xhCspg1PRhfsLFaO/mlNJMVpAMLqJRLQDM0poSHd/zbpv4pdUu6hK07pR
         mNqDaXk53eqfE5U+f2Z8TkReG/HJ+ecuC104RamLEpzAYUbw35sXtLQ7Z/PcGcpNTjHk
         c9y2UgcqOPUV/Z5m9TCB7Sfydf62XkMQfHQLXmGF4W2P5n95O9TXOHr8EHShpixSwqVA
         vySaJ6jf1QVcVgOB+W2Rtmj9JAge7bkf8tZ0MoLJlf9tQ+gFJFaOnzK51nvw7pa2LKyj
         3ebM7+oCpXoy6/8IXBAmwe7EVgsDHZuRDhtj+vTZxKSKAu9N6sEktSmJSZBagF2ZSEjv
         ow/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=17kpobL9pe7DY0967paYNJ+En7t5oWpJIpEYf5k48PQ=;
        b=dVHcxS1dhbBDhxTAopJWNgOReWuunzpGYWwDepQKPX4s5msUCeFThR1QDw7BSbQRiK
         o4gF100o0HzTcYht8Y72TB/PoWG1PtTAvCL1Uzt3CRFUOXdJzHtt2+FAXQvyPMbkVp/C
         eWwNXKKi7SlmwCnpJLKlphZcmJ/gUKetmSAnJplPyiyQBL4RudRWEWqTwpZ8UqKBlZ7Q
         3ZbK1Wlh5KxD72K5DDP0EIIYmePOf+IzZYkMhkJbyFGK1h0BMFIfD1a8RFpcwojVRVK+
         Gz5AciJLcr1JuDHmHdKc/DUVH41tfQYaJXwXhXLfB2iQP55/CcaqqItX+IheDNA7VhE7
         omaA==
X-Gm-Message-State: APjAAAVZzusnj9BR8SbxllDp5JhTSd8Xve96miPqRoQWiR4x2hQKqgC/
        +aNWOKazqifrvzgoFkzxSWM6jQ==
X-Google-Smtp-Source: APXvYqwpEq+4n2t5EMT1AbSeu6+mFoAJPz1VLAcg9IzfsLOq3hCvn7lOrZjSBjWtyfcdCvyGQxBjdQ==
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr17881421wmd.102.1579507492645;
        Mon, 20 Jan 2020 00:04:52 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id m7sm1820762wma.39.2020.01.20.00.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:04:52 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:05:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        baolin.wang@unisoc.com, chunyan.zhang@unisoc.com
Subject: Re: [PATCH v4] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20200120080508.GR15507@dell>
References: <1579397619-28547-1-git-send-email-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579397619-28547-1-git-send-email-orson.zhai@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020, Orson Zhai wrote:

> There are a lot of similar global registers being used across multiple SoCs
> from Unisoc. But most of these registers are assigned with different offset
> for different SoCs. It is hard to handle all of them in an all-in-one
> kernel image.
> 
> Add a helper function to get regmap with arguments where we could put some
> extra information such as the offset value.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> V3 Change:
>  Rebase on latest kernel v5.5-rc6 for Lee.
> 
> V4 Change:
>  Remove trailing spaces according to checkpatch.
> 
>  drivers/mfd/syscon.c       | 29 +++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h | 14 ++++++++++++++
>  2 files changed, 43 insertions(+)

Nope, still not working:

 Applying patch #1181935 using "git am -s -3"
 Description: [v4] mfd: syscon: Add arguments support for syscon reference
 Applying: mfd: syscon: Add arguments support for syscon reference
 Using index info to reconstruct a base tree...
 M	drivers/mfd/syscon.c
 /home/lee/projects/linux/kernel/.git/worktrees/mfd/rebase-apply/patch:25: indent with spaces.
                                        const char *property,
 /home/lee/projects/linux/kernel/.git/worktrees/mfd/rebase-apply/patch:26: indent with spaces.
                                        int arg_count,
 /home/lee/projects/linux/kernel/.git/worktrees/mfd/rebase-apply/patch:27: indent with spaces.
                                        unsigned int *out_args)
 /home/lee/projects/linux/kernel/.git/worktrees/mfd/rebase-apply/patch:36: indent with spaces.
                        0, &args);
 /home/lee/projects/linux/kernel/.git/worktrees/mfd/rebase-apply/patch:38: indent with spaces.
                return ERR_PTR(rc);
 error: patch failed: drivers/mfd/syscon.c:224
 error: drivers/mfd/syscon.c: patch does not apply
 error: patch failed: include/linux/mfd/syscon.h:23
 error: include/linux/mfd/syscon.h: patch does not apply
 error: Did you hand edit your patch?
 It does not apply to blobs recorded in its index.
 Patch failed at 0001 mfd: syscon: Add arguments support for syscon reference
 hint: Use 'git am --show-current-patch' to see the failed patch
 When you have resolved this problem, run "git am --continue".
 If you prefer to skip this patch, run "git am --skip" instead.
 To restore the original branch and stop patching, run "git am --abort".
 'git am' failed with exit status 128

Please talk me through how you are sending the patch.

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index e22197c..2918b05 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -224,6 +224,35 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
> 
> +struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
> +                                       const char *property,
> +                                       int arg_count,
> +                                       unsigned int *out_args)
> +{
> +       struct device_node *syscon_np;
> +       struct of_phandle_args args;
> +       struct regmap *regmap;
> +       unsigned int index;
> +       int rc;
> +
> +       rc = of_parse_phandle_with_fixed_args(np, property, arg_count,
> +                       0, &args);
> +       if (rc)
> +               return ERR_PTR(rc);
> +
> +       syscon_np = args.np;
> +       if (!syscon_np)
> +               return ERR_PTR(-ENODEV);
> +
> +       regmap = syscon_node_to_regmap(syscon_np);
> +       for (index = 0; index < arg_count; index++)
> +               out_args[index] = args.args[index];
> +       of_node_put(syscon_np);
> +
> +       return regmap;
> +}
> +EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_args);
> +
>  static int syscon_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> index 112dc66..714cab1 100644
> --- a/include/linux/mfd/syscon.h
> +++ b/include/linux/mfd/syscon.h
> @@ -23,6 +23,11 @@ extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
>  extern struct regmap *syscon_regmap_lookup_by_phandle(
>                                         struct device_node *np,
>                                         const char *property);
> +extern struct regmap *syscon_regmap_lookup_by_phandle_args(
> +                                       struct device_node *np,
> +                                       const char *property,
> +                                       int arg_count,
> +                                       unsigned int *out_args);
>  #else
>  static inline struct regmap *device_node_to_regmap(struct device_node *np)
>  {
> @@ -45,6 +50,15 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
>  {
>         return ERR_PTR(-ENOTSUPP);
>  }
> +
> +static struct regmap *syscon_regmap_lookup_by_phandle_args(
> +                                       struct device_node *np,
> +                                       const char *property,
> +                                       int arg_count,
> +                                       unsigned int *out_args)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
>  #endif
> 
>  #endif /* __LINUX_MFD_SYSCON_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
