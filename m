Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2F4CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F61420675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R75BSXoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgEMKs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEMKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:48:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61079C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:48:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w19so13175341wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DkTu8Boy9+QFrN/nz9Dlp+esnFEQSCB9OlQtV2ZrE7g=;
        b=R75BSXoo/V9oojjqwA3xBMD3P4vlpXd3u9G2gA7d4K574Evnf5YbrWWh+MGgJzlRmY
         v1SYw72qo/2orD01DCCs6OJmX8zpu4Uj6M9TykGeeBcBBUXlh2oBFAV6WlVzt2ddERvJ
         0oE88kPY+xs/eeYEO50EPToSNjn+iue4TmSdkGMZbnorC6LpOR0aKfaLHLFbI9zn7kuP
         jFTLhAF4AdrzPshcFYHolAqw0VaLGa/ZZ9ozjDPA9+YBafjJWAKOH1XyjRMzS4HtINQY
         PSM5KlyRMM1H6oC2eewNV3faKxvpmbWqilenWE9pZ0cWG/Vzk8PzbEvUCt7ukN3wzUub
         tu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DkTu8Boy9+QFrN/nz9Dlp+esnFEQSCB9OlQtV2ZrE7g=;
        b=P4lSrntNiQKT3f0BjNoWqf/wPsBQ5IgBGFfkDM1bml0sw+ou6wu80hq2/xYj1EC9+n
         WCbwJ7Zt2OjyMxY4VnoQpJYeV/9/o6Xwp8hf6rSlSzfTPnnrLX/stXj/z5+woKwD2n0W
         nAB68oUCjqXrQf5XipgWOJXFDsNwpx+bDRFOCednVNMqyrP5Ofrt+44j2m/eJnseJWof
         3AtUYULUGPB946InbXlmfK1G8f8CJ2kQ0uXRzH1y2mp29W9WrJLCVwdyyukhy8HIpjn1
         qmnRwanlNDc706RhzuoLRKn4pMjTKEsafsYyO+c8O5Y73WrLoJX67+KM1LBt48Gd7zBR
         0CVQ==
X-Gm-Message-State: AGi0PubzRv1U4aImimoXBJZ8j19aOBUaE9j+swlnz3FImGFs7uYandzt
        xi0ZHfpcTRv6gmNp25X4fMhirw==
X-Google-Smtp-Source: APiQypI/miEqKd1bRU5KlIz6q+mV3Wo21I4z4di7LSyrHxy1dzFnHEBiY8isceJjKhRMQ+TuIif8YA==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr41466821wme.174.1589366932710;
        Wed, 13 May 2020 03:48:52 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com ([2a01:4b00:8523:2d03:e021:170a:2079:28ea])
        by smtp.gmail.com with ESMTPSA id p4sm15896164wrq.31.2020.05.13.03.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:48:51 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date:   Wed, 13 May 2020 11:48:50 +0100
To:     Marc Zyngier <maz@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] arm64: kvm: Formalize host-hyp hypcall ABI
Message-ID: <20200513104850.6rer4ued2uq6lpxs@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-3-dbrazdil@google.com>
 <87d07fj3g9.wl-maz@kernel.org>
 <20200507133320.GA16899@google.com>
 <871rns14dl.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rns14dl.wl-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In fact David already has a nice patch that transforms the whole thing
> > in a jump table, which is much nicer. I'll let him share the details
> > :)
> 
> Ah! Looking forward to reviewing it then!

It's not actually that different. It still has the same header file, just uses
the macros to generate a jump table rather than an array of function pointers.
The main advantage being that we can avoid .hyp.text dependency on
physvirt_offset. Feel free to have a look, branch 'topic/el2-obj-wip' at:
	https://android-kvm.googlesource.com/linux

Perhaps this is not worth the trouble. We do hope to get to a point where the
ABI between .text and .hyp.text is formalized, but in my mind that ABI is
unlikely to be using this same hypcall path.

On the other hand, I've played with preserving the function-pointer interface
in the last couple of days and later in this series we do end up having to
declare all of the hcall entry points (which now have two ELF symbols), so we
end up with a similar table regardless, just with no IDs assigned.

-David
