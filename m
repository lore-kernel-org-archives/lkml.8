Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25915C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007AD206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0S+iJQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHHWtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 18:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHHWtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 18:49:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401F9C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 15:49:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so2745106pjx.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ywCTPY4bZpNxwToTdnk62PFiS8+In3aA+96LZvQPvtU=;
        b=W0S+iJQhRjLsHp3h9LbUcRfBAV0Rb1p2ciZVu5gI6NqaqzHc/BuhZtNzie1OsdWojK
         xNyusKGM4u21kxAQhBeJlO2alDe5hzVF3AfxuIVZwc8FTNiKLO142LG600NfrhFOohlX
         Qqi8hDFM51A0u9Sdgic2VigRspe1+RhFl0n3RrIY4Cc0Dt9FTU/WmPgNx/7vuGXIjq6D
         7tmGXW3AsG3E9M4Hx4bjxfUWplvMfGzmI59VtAgwLJEu9Kh8IU5yqwBpav3xN47al3hv
         IRz/coFQTs0o2wDvZEf4vCTUlTsKhLIQdOO0jbkY5wNrRpkFSGfko3PIVQTXKSwD7Zbi
         hgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywCTPY4bZpNxwToTdnk62PFiS8+In3aA+96LZvQPvtU=;
        b=Z/2Eb5G3YeBiBw7LJEnxbGPZbijos9cPYJ/Dpb7XM+SJ8qcEhNyfHCFA0iRxvRZCkv
         BOBjNN6ZAsgEUZ+OzO5lnivCE980pBRHs8U4cbIgwGpeELWfvmiGuE9hFYhcTA1SAjG7
         VtxYjkVUQEu1VoMDIhpukRJpk4M6apH+T1L9VlCSN+vZ9xZP/WKoaMbd4Qfq+cIhzkhN
         BRuim3xUTAQL8FdBL/28oGFqx5xcVG4isgOmYm5XLLegsYhqiKtpIPs+7B4m5qXRm0BH
         kjgzVJxdC2jzG0hf+P3QSevYSHh29bkb7Hhd8ctFWMZM2gi+rS04luXL/9PC7AhzvQLO
         Bc0w==
X-Gm-Message-State: AOAM531QQ2oFkNbHGM2IuC35e2Ffv7TqM1AG3KDK9aTzyI2k6sB8Z25F
        BO6NVig7H1sX8LACHo6/UNaM3swF
X-Google-Smtp-Source: ABdhPJxI8Y0cjzo3bxkaeo/qMhUIA1/BJUkspqYpl2q2K6DL/voaZHyST2ot9gq4jmB8Qp7MeTwcOA==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr19822888pjr.213.1596926957834;
        Sat, 08 Aug 2020 15:49:17 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id s67sm19372160pfs.117.2020.08.08.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 15:49:17 -0700 (PDT)
Date:   Sun, 9 Aug 2020 07:49:15 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] OpenRISC header and sparse warning fixes for 5.9
Message-ID: <20200808224915.GR80756@lianli.shorne-pla.net>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200806191146.36xlfjwehe5lorav@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806191146.36xlfjwehe5lorav@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:11:46PM +0200, Luc Van Oostenryck wrote:
> On Thu, Aug 06, 2020 at 06:07:19AM +0900, Stafford Horne wrote:
> > Hello,
> > 
> > Changes since v1:
> >  - in "io: Fixup defines and move include to the end" added a linux/types.h
> >    include as there were compiler failurs pointed out by kbuild.
> > 
> > This a series of fixes for OpenRISC sparse warnings.  The kbuild robots report
> > many issues related to issues with OpenRISC headers having missing or incorrect
> > sparse annotations.
> 
> The changes look quite good to me (I just add 2 nits for patches 5 & 6).
> 
> Fell free to add my
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thank you.
