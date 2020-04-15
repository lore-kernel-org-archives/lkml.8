Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFDFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC44F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxULmgnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393232AbgDOFE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389851AbgDOFEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:04:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E0C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:04:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z9so6191184pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gsvhzAYTICdpnZMJaCTeJO6AmyzT9TU4Pb3xpqq5oiM=;
        b=PxULmgnqNny6YFWfOOUOVtVrHM9RjGJGFlDy2Xftlow9qvdiStdegCV5pmbe9/OBsm
         FY8LhhybDngKpozgzCwPmhRpeH8AsXmDy0iBWKnxif9GErLA/0fN4KK6jLOyNqEty1Bt
         P4JHnD4wn0Let8iytBk+JGgQiHlP0StMJi2gxac8J4wipqNNh+l22rMK3Ebhk8h99rKA
         wC5qzTTJLeRabr7k9C2MuUwhsb+ntMbkoRa+HZfOp1X4l54jeJPFhxsaZzyax32WpWgk
         JPn4kEgZZaYLs6qvYIGGeJf8nAPoGFOW8oUd65EcYsN1AUpcDmS/9SL7/wREVOVWzblB
         IfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gsvhzAYTICdpnZMJaCTeJO6AmyzT9TU4Pb3xpqq5oiM=;
        b=jbtsqTC5W2o4PU9FyMU5wJJNZqGGreW0fdVSjMdj4sxCeblcI0hQZ/khYg4bgyXofC
         EKB1AhSMVY6HIlgQYApkq5H5K6sg48PrtAypFzh3Q2gy4PYIa4GeOkOQ5vwT5SCFMJRQ
         5Wcbb1QTO0EM0RqNyUsVU2E/EaOS4uWIF0vJByH0Qi+w364objFJRbi3O3LfIe3l6hOF
         fAeSD5IRa7Dh5B50g8ziDjh4vteZXwiCgCeTVHzg2Nr3fU6pEZR5S6qw6DO0zkjXULa4
         o0ak/F3MTNYfLCQhcB8aB8UFGOZ4XMwjWolbVBmfP8sg+by43+9pdgOcS5cc7b6BEANB
         L1rQ==
X-Gm-Message-State: AGi0PuadjtdYi7aNiD4DKrsfT1io2DgxleBt7vk9h75T52MtG1Ztmmxj
        +fSo8ymRR4GBNx3k1s03O7Eg9w==
X-Google-Smtp-Source: APiQypLHT3hqd2R5xgQm+zhqokQokSCVxtF2OYRc67SBIEoGnMYtLF8ewhBgG/9b8oC8YYprDgLO0A==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr4267514pjb.108.1586927063249;
        Tue, 14 Apr 2020 22:04:23 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n21sm11312923pgd.93.2020.04.14.22.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:04:22 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:04:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the qcom tree
Message-ID: <20200415050420.GA987656@yoga>
References: <20200415102534.6d22a377@canb.auug.org.au>
 <158692631073.105027.12648118734810371009@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158692631073.105027.12648118734810371009@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14 Apr 21:51 PDT 2020, Stephen Boyd wrote:

> Quoting Stephen Rothwell (2020-04-14 17:25:34)
> > Hi all,
> > 
> > After merging the qcom tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> > 
> > drivers/soc/qcom/cmd-db.c: In function 'cmd_db_debugfs_dump':
> > drivers/soc/qcom/cmd-db.c:281:30: warning: field width specifier '*' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
> >   281 |    seq_printf(seq, "0x%08x: %*pEp", le32_to_cpu(ent->addr),
> >       |                             ~^~
> >       |                              |
> >       |                              int
> >   282 |        sizeof(ent->id), ent->id);
> >       |        ~~~~~~~~~~~~~~~        
> >       |        |
> >       |        long unsigned int
> > 
> > Introduced by commit
> > 
> >   d6815c5c43d4 ("soc: qcom: cmd-db: Add debugfs dumping file")
> 
> Thanks. I didn't notice this warning. Looks like we need to cast
> sizeof() to int? Bjorn do you want another patch or does this get
> squashed in?
> 

It's in the middle of the patch stack, so I would prefer an additional
patch.

Regards,
Bjorn

> ---8<----
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 6c308f92a13c..6b5c440c9dc3 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -280,7 +280,7 @@ static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
>  		ent = rsc_to_entry_header(rsc);
>  		for (j = 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
>  			seq_printf(seq, "0x%08x: %*pEp", le32_to_cpu(ent->addr),
> -				   sizeof(ent->id), ent->id);
> +				   (int)sizeof(ent->id), ent->id);
>  
>  			len = le16_to_cpu(ent->len);
>  			if (len) {
