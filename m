Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5232078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcUuhelf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgFOVel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:34:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731540AbgFOVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592256878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItwxuioZVdA5XdCXR1QbAewm4+8qdb0KbH1lb+9ehrA=;
        b=WcUuhelfjzauD8OT/s7bZSsgGru935WmqNs4D3r2x6lqmSO2+3c/8SE0+e9OSg/Vwad3MU
        vkFYi1o17tTey3QjbFGKCYG3eFq9O1BAQ2HFIy2bsUf08Ya08LR41zLn4wJoRIx7HDP/5i
        SPS1k6bt2F7pCFengumhAmmLuKbGN1s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-sfCdQm9_OtCfq_Bmtta-0g-1; Mon, 15 Jun 2020 17:34:34 -0400
X-MC-Unique: sfCdQm9_OtCfq_Bmtta-0g-1
Received: by mail-qv1-f70.google.com with SMTP id z7so14076375qve.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItwxuioZVdA5XdCXR1QbAewm4+8qdb0KbH1lb+9ehrA=;
        b=F2W45ymVEDbAoLttHSLrfniTkNOT5TP7qR7tBEP0F3gXNjGHTtyzVuSoeHxOm84VU8
         Z85H5tLgkqq8skoTobW8qXfxKonNgJWA414XRQQv/auM2SryuwiIx+IOGkttcRpLgOTI
         b2CRIBnS9czq7VRHn2pWGbCpA9lAIHJJAUGLnwwvFNjQ3udIjgS7uKn2TJMvoIeLcJ3H
         RnBkxm3rdJfX92VcRznypgZE8pFJu+0Vij3qSXYZ3i9TPq1GqUAt8df28LFZ4lFZMyTO
         XewsszErznWQGBtQtv5y0T6xt/VD+fM4jaNHYG2JkViLqNr6qjZZMWJz1+mPUSYAdeux
         GCQQ==
X-Gm-Message-State: AOAM530OHMWbzdxQn+i/eNAy+enDBrPNnSE//uu0Y6kKsXPu5ZDzJ4Qe
        VaEbejlzc5nK5xu8rxj2yqjCFJJLza94to7773EoHSsy8KDHDDeprjLCuxB1Z5U+XDUxDbXS+VL
        oXstU+j/seqjhN5knwvrAsxZj
X-Received: by 2002:a0c:ed31:: with SMTP id u17mr25540571qvq.117.1592256874107;
        Mon, 15 Jun 2020 14:34:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0iHGiHde51cucRTUPE7NzfM/1jQRbNlFV4ChXmFExBXup/Ay4TPRKGywEeToUwHIWcL2Psg==
X-Received: by 2002:a0c:ed31:: with SMTP id u17mr25540552qvq.117.1592256873805;
        Mon, 15 Jun 2020 14:34:33 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f30sm12961493qtb.9.2020.06.15.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:34:33 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:34:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Guan Xuetao <gxt@pku.edu.cn>, linux-xtensa@linux-xtensa.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Possible duplicate page fault accounting on some archs after
 commit 4064b9827063
Message-ID: <20200615213431.GC111927@xz-x1>
References: <20200610174811.44b94525@thinkpad>
 <20200610165023.GA67179@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610165023.GA67179@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:50:23PM -0400, Peter Xu wrote:
> On Wed, Jun 10, 2020 at 05:48:11PM +0200, Gerald Schaefer wrote:
> > Hi,
> 
> Hi, Gerald,
> 
> > 
> > Some architectures have their page fault accounting code inside the fault
> > retry loop, and rely on only going through that code once. Before commit
> > 4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times"), that was
> > ensured by testing for and clearing FAULT_FLAG_ALLOW_RETRY.
> > 
> > That commit had to remove the clearing of FAULT_FLAG_ALLOW_RETRY for all
> > architectures, and introduced a subtle change to page fault accounting
> > logic in the affected archs. It is now possible to go through the retry
> > loop multiple times, and the affected archs would then account multiple
> > page faults instead of just one.
> > 
> > This was found by coincidence in s390 code, and a quick check showed that
> > there are quite a lot of other architectures that seem to be affected in a
> > similar way. I'm preparing a fix for s390, by moving the accounting behind
> > the retry loop, similar to x86. It is not completely straight-forward, so
> > I leave the fix for other archs to the respective maintainers.
> 
> Sorry for not noticing this before.  The accounting part should definitely be
> put at least into a check against fault_flag_allow_retry_first() to mimic what
> was done before.  And I agree it would be even better to put it after the retry
> logic, so if any of the page faults gets a major fault, it'll be accounted as a
> major fault which makes more sense to me, just like what x86 is doing now with:
> 
> 	major |= fault & VM_FAULT_MAJOR;
> 
> I'm not sure what's the preference of the arch maintainers, just let me know if
> it's preferred to use a single series to address this issue for all affected
> archs (or the archs besides s390), then I'll do.

To make sure this won't fall through the cracks... I'll give it a shot with a
single series to address this issue for all archs.  Although it might not be
easy to do accounting directly in handle_mm_fault(), it might be still a chance
to introduce a helper so the accounting can be done in general code.

Thanks,

-- 
Peter Xu

