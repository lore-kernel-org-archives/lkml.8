Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954EC2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWBEgGPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgH0Ofq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgH0OQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:16:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142CC06121B;
        Thu, 27 Aug 2020 07:15:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id u1so5068416edi.4;
        Thu, 27 Aug 2020 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NXkLLdStZAp/ZkgGou+K3F4imj0vfXH+Hp3m3xXWcro=;
        b=MWBEgGPw8K6mkTY5BsXwDG/tkAjCutG31ed3J4GGXW64ymyLGydPe5Y+l849kuTZL6
         yv84qalw1kG2lf823+h65AY4/B9+NSJY481zea/luna/GIkP0oPfmhFJn/8keppiM8HL
         /SU0jHblLyZ6Fdb2IXT2VWwSI1VqCq4c/opm/cTdpwosuw4J1RGDXrwcpv1HHQci5LJJ
         L1kcIGvLFSYC8PXfNMj+9hz0zT2sAos9PBYkcQU0K/b0JWfRf/H1E6qpHc0kZMYFCkgQ
         SQC6ndi9zdcpr+n2uqrG+rN5p/AlMePr1/S/lLgE+JHjac1tRZlNrHZdP+7SstWj8Y0h
         i14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NXkLLdStZAp/ZkgGou+K3F4imj0vfXH+Hp3m3xXWcro=;
        b=VOFIH7BUGkMYOi9stquBflk04DoViY9QegEYo/4amKCMW2uG+8rt3VCwrSvACvtQUO
         KHmWU0prCHzqKWc/CO5kk904rDMJRM+AyXsjjbsrvTkFO858xywSEHzHsf4YcTInu3dJ
         uLafhg7zYoA6B3jWDrVyeNxj92TdbqnGkVb/KQBhYmnrv1P8u4TV4eajjCw5VE2aQfJM
         SS+vZ8JxFBktKgnr5CPUq+xUSzdOLCCifB+3zutvN37EWGSlo19YerY9ThSelJeLWYae
         ttecVha57YVQCIVvk/p2oXZrqvmdA4JMt+E0mFXLRW0surZ7Xe9dv0bGJzOiPqzLrAD2
         jvHA==
X-Gm-Message-State: AOAM5306j13rnhjQ+FAicpcSjLFhHersIo7EguJkfAB/xQ8msoVWk2Ne
        GoVnTVTX+h/CzQ6lX9IgnM8=
X-Google-Smtp-Source: ABdhPJwr1Ohh7U+k+NbwwlGg9XlS6X9acHkKu4ucrrjGVFuW8d6WFhqWj8pq3Nfa8c8Ce6BBYEZeNQ==
X-Received: by 2002:a50:9d8a:: with SMTP id w10mr19602085ede.16.1598537723356;
        Thu, 27 Aug 2020 07:15:23 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id d17sm1575988edr.78.2020.08.27.07.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:15:22 -0700 (PDT)
Date:   Thu, 27 Aug 2020 17:15:20 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm: dts: owl-s500: Add RoseapplePi
Message-ID: <20200827141520.GD2451538@BV030612LT>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
 <2d12521d196e2c08a30aacd0ab20d93593f94707.1592123160.git.cristian.ciocaltea@gmail.com>
 <87v9h4y4dj.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9h4y4dj.fsf@dell.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for the review!

On Thu, Aug 27, 2020 at 08:44:40AM +0200, Peter Korsgaard wrote:
> >>>>> "Cristian" == Cristian Ciocaltea <cristian.ciocaltea@gmail.com> writes:
> 
>  > Add a Device Tree for the RoseapplePi SBC.
>  > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
> 
> On a related note: There is now an owl-mmc driver for the s900. From a
> quick look at the datasheet it looks compatible with the controller on
> the s500. Did you have a look at hooking that up?

Yes, please see:
https://lore.kernel.org/lkml/cover.1593124368.git.cristian.ciocaltea@gmail.com/

The clock related patches have been already applied to v5.9 and
hopefully the pinctrl driver will follow in v5.10.

> -- 
> Bye, Peter Korsgaard

Regards,
Cristi
