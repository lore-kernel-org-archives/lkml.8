Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0949DC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61C824656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582113540;
	bh=5t7RVi7d1DF7cBi+WWlmmtS2h+FCypjBdjO28ZK4QWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rw6ORsE+buKgyI3oKFKiuIqreqs/J87BInub7svPzSYrcKsuL+qvU22Vpc4apChPj
	 afCev6XojzrYyI4m1Zt7b6K/xOQMycECMp/UXXFp3bIrEH1mtHwXHpBepxxzzTbyRH
	 WAOQxfsVkdrmGVnj22gzsvbYULK+16vUCvv+gRsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBSL67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:58:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38664 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgBSL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:58:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so344193wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hMj17EsNTTVBvIYortqF9yZ/0MuAB2i6oYeLezbsqUE=;
        b=UZLnRoYwpr0wJuwDu0563+hpiwJtvhYtDOQ90n5c2HsdNVGcZAsnTX/hNfiF+tLjFl
         P0uCRuaeEvRBgUrEVieWePUpzsEyq0IUI4XIYIv8/by2IOpuOFSPz28f0jneW608JFTB
         EoBJCOA4Okd0FtUMWSuxOvfrYvD/5KyfmH63x82MNDlj9UDj575dRDmkvjyUUy8Ml9Ew
         qE0ZsnKj+QVgu5LkJhroZTE74haDmMSUK1gBfJ5nm0nO2j9oK3pwezVvbs1O71sSQUBB
         Ne10kDxdApLyDMpwwi6THT4xd5CJbdCeJktFVNoZSsMKvXxAznYFJIh9dTaJzNfElh9w
         efXw==
X-Gm-Message-State: APjAAAWW7Ccsbvo8ffu1daeXGcSGJ89ovVOmp0KofPQVeiqZ5Q9t4lFu
        uRukDI25GjRmk5knyTTxyi8=
X-Google-Smtp-Source: APXvYqyJLNBDsyGu5ycOv4YzZpKZsQi+8mdg5QMCtZtvivgqipvSvIX9TS7n9r8PLIChj38ff/LUbw==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr9797015wmi.107.1582113537324;
        Wed, 19 Feb 2020 03:58:57 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t1sm2829859wma.43.2020.02.19.03.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 03:58:56 -0800 (PST)
Date:   Wed, 19 Feb 2020 12:58:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] mm: use_mm: fix for arches checking mm_users to
 optimize TLB flushes
Message-ID: <20200219115855.GR4151@dhcp22.suse.cz>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-2-aarcange@redhat.com>
 <20200218113103.GB4151@dhcp22.suse.cz>
 <20200218185618.GB14027@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218185618.GB14027@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-02-20 13:56:18, Andrea Arcangeli wrote:
> Hi Michal!
> 
> On Tue, Feb 18, 2020 at 12:31:03PM +0100, Michal Hocko wrote:
> > On Mon 03-02-20 15:17:44, Andrea Arcangeli wrote:
> > > alpha, ia64, mips, powerpc, sh, sparc are relying on a check on
> > > mm->mm_users to know if they can skip some remote TLB flushes for
> > > single threaded processes.
> > > 
> > > Most callers of use_mm() tend to invoke mmget_not_zero() or
> > > get_task_mm() before use_mm() to ensure the mm will remain alive in
> > > between use_mm() and unuse_mm().
> > > 
> > > Some callers however don't increase mm_users and they instead rely on
> > > serialization in __mmput() to ensure the mm will remain alive in
> > > between use_mm() and unuse_mm(). Not increasing mm_users during
> > > use_mm() is however unsafe for aforementioned arch TLB flushes
> > > optimizations. So either mmget()/mmput() should be added to the
> > > problematic callers of use_mm()/unuse_mm() or we can embed them in
> > > use_mm()/unuse_mm() which is more robust.
> > 
> > I would prefer we do not do that because then the real owner of the mm
> > cannot really tear down the address space and the life time of it is
> > bound to a kernel thread doing the use_mm. This is undesirable I would
> > really prefer if the existing few users would use mmget only when they
> > really need to access mm.
> 
> If the existing few users that don't already do the explicit mmget
> will have to start doing it too, the end result will be exactly the
> same that you described in your "cons" (lieftime of the mm will still
> be up to who did mmget;use_mm and didn't call unuse_mm;mmput yet).

Well, they should use mmget only for moments when they access the
address space.

> One reason to prefer adding the mmget to the callers to forget it,
> would be to avoid an atomic op in use_mm (for those callers that
> didn't forget it), but if anybody is doing use_mm in a fast path that
> won't be very fast anyway so I didn't think this was worth the
> risk. If that microoptimization in a slow path is the reason we should
> add mmget to the callers that forgot it that would be fine with me
> although I think it's risky because if already happened once and it
> could happen again (and when it happens it only bits a few arches if
> used with a few drivers).

The primary concern really is that use_mm is usually not bound in time
and we do not want to pin the address space for such a long time without
any binding to a killable process.
-- 
Michal Hocko
SUSE Labs
