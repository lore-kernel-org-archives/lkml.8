Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C040C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BBD20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWSt17Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgERP3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:28:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F707C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:28:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so9723317wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4WixP9zOQESaEUk+grq6tjXSo20K+tLvJTvsRgnudUk=;
        b=RWSt17Q/P+CTGFhSHnF5vSVIgqEukfT/ue7prWyK3v1ihEQJc74VjQg5Bf31WcJ8k4
         jouQvwUwfngsU4A8QwLSizOwMcPiatSqqmPp2eqpf6+ZgdMWG/CwdnXnaFSH95kncofW
         /3vslGy5j3My4P0CocjIZaqunf0B3RGMsfOFHTDhT1yA7eMR65w13RBfRRWu9A2RRq3w
         PhKzgdxDPMxyMmYxNMqqiqB7BAkv8RHT8Cfw12/pH5LYoKTZyT5pss5xdr7wLA3w5YHj
         TGlG5y2rQLbmZQRREQPmyNEeDBoqsCtgSPI8DYfBiw0OQQSr8AvpQOsVY9LVCxvlB54i
         kMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WixP9zOQESaEUk+grq6tjXSo20K+tLvJTvsRgnudUk=;
        b=VF/JDirs8x14IG4XWEyMBDyVvRUsA9fm2kj9T2zd/HtUP/YN98QR22cyhSE5KDDEC8
         sQopVazNULXb1CVNCcA8r2v9iJgHNnAEQbD1lAfFlB0IcFuSpYLHVqyev58uB+2KqXIe
         A9XetoWdKb7qxMHJLnHnCLJDicIOqnBwBBdJEN9juX6WAWMBG2Ga/9mFiX+c+60TSGkX
         hCu4Q24tzy4t9SzHWmdMoR9ZVN/7XihJIqD+LlHjfI2R485JlSxQZ8PZdrrqmezIGMVt
         6CMcCx8ZIO3j/lL7H3hO1SsaIbOI/WgTimuzmPotcSNRzNQLqns2zf67G2ovpA1PPJHW
         CwmA==
X-Gm-Message-State: AOAM533QJW7RxoAcaAIDw7ztaS3WTt+A1w1mxq9SOzwwg2GorlIS6A7H
        NEbRTa688Q7nSqIRIPD+hvvf3w==
X-Google-Smtp-Source: ABdhPJxNgUPicwALsWOh/eNYOxbadohP9rcnrjnk2Eie3S7vO1kCgSNAmXH0HQ9ZKDHh7XTExrpDBg==
X-Received: by 2002:a05:600c:1006:: with SMTP id c6mr20951848wmc.133.1589815736776;
        Mon, 18 May 2020 08:28:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:355c:447d:ad3d:ac5c])
        by smtp.gmail.com with ESMTPSA id r2sm17269506wrg.84.2020.05.18.08.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:28:55 -0700 (PDT)
Date:   Mon, 18 May 2020 16:28:51 +0100
From:   Andrew Scull <ascull@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] arm64: kvm: Split hyp/switch.c to VHE/nVHE
Message-ID: <20200518152851.GA147668@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
 <20200515105841.73532-8-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515105841.73532-8-dbrazdil@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 11:58:34AM +0100, David Brazdil wrote:
> +__kvm_nvhe_sve_load_state = sve_load_state;
> +__kvm_nvhe_sve_save_state = sve_save_state;

Building without CONFIG_ARM64_VHE leads to a linker error due to the SVE
functions being referenced in this list. This is caused by
CONFIG_ARM64_VHE disabling CONFIG_ARM64_SVE and, in turn, preventing the
generation of those symbols. There aren't any references from code, just
this file.

It can be resolved by having the SVE symbol aliases depend on
CONFIG_ARM64_SVE.
