Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92238C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688A32070C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pI+z1f36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGCCq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGCCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:46:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F32BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 19:46:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g139so17501082lfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 19:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Eal33Mv8b1H/h4IftAYSAXGyqqz8yFRIB607WgFe1P4=;
        b=pI+z1f36Cq7rcUpt/+uR6YAxQ0Rrrq5bCVA7x/F6qRq9FuoxiF7dVIdNmfNxG/NuK/
         7pO1GyYRHTYuMon4bTMfo08Um7Z1v5DdjHnV0+0kX/YQdqW1TgnDQuOUURedx8c6TJNL
         ZZGgOdc7wlHP4XflcFloSI0Emmpt/xJb9cSbVQ1o/MQ3RiTSC2EDYmBzUBuLWqIV+he+
         xk9F+I1Ezz9/yl4AsXtVllKw31EOIyZB59IkmsGUlh+kYjklxk/vespI5KnTedpZxz8c
         43qhZztO9kCK2yfwMeWDpTaDUaoQa1fu4XayteLrSAN4BOJ094xJaXD7LLWrOtTmT8Rn
         on5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Eal33Mv8b1H/h4IftAYSAXGyqqz8yFRIB607WgFe1P4=;
        b=H3BuNABWITIgHO26UuvUuu92SG4zgW8xv6sYRYrOYeoHX++HQaZIDNnGRd9Jrpj4Jf
         PGiFohGcP40J8yM5xUYFAp6kZSxCJ0a8yXnE3gNNRq5h2XuHfaBt1LfhV5S2GxXqFC6D
         BkTMy1b/MoRhP0kqlqJJbZmpekJ9Tg8FiESucDwfC3nwBrqj7lgMr2uaJJe5qWYNTuV2
         QaJilpGY3hnPe8XIQYbZwBzqcmiEDNQIaDVATHdVvU6QNtbMPCtrCNlxUo99JrTD9MZC
         MAEHIOlfaddiGznfHu4HG/oOnmKW/1pLg2Ny6/oLggjHhEGAOYzeV8Y1a+VnYJej28mp
         CqPQ==
X-Gm-Message-State: AOAM532OskmUd5cwLpZCJmDhggZpY+RWNoQsa/WhWlyBaVaypho2GjR3
        7LNpmrmqdfHp6ctvkn26EMi8Eq7Jku/D8ZOuOOY=
X-Google-Smtp-Source: ABdhPJxR7Ht4Go78RJHC6zfXuavNs1NoV6Dkbp2qL+5fBSUunnBEgiWyPdESePolhUBC8sTwBXwejJZDJrFxdBnUUXA=
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr19691281lfg.196.1593744413398;
 Thu, 02 Jul 2020 19:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200630005625.2405062-1-daeho43@gmail.com> <961072bb-4c8f-b01e-666d-1f5e35a8b76d@huawei.com>
 <CACOAw_wQx5wjdWDX_WFebNS42t=wBuSh_k7oQ4v7abBv80SZXw@mail.gmail.com>
 <9d1afacc-6033-2bae-d55d-909d50f1904b@huawei.com> <CACOAw_zFLgeoomdHhRmzYMtCocTugW5AVxb2wZnoRAC9+hR9Gw@mail.gmail.com>
 <ee97fa6e-33df-04f9-ec37-6b7d7b495acb@huawei.com>
In-Reply-To: <ee97fa6e-33df-04f9-ec37-6b7d7b495acb@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 3 Jul 2020 11:46:42 +0900
Message-ID: <CACOAw_y23emnXdmbUJT_QDdF42EGJ9p4-ZuC9caJBGTpLWbR=g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add symbolic link to kobject in sysfs
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.

Thanks~

2020=EB=85=84 7=EC=9B=94 3=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:02, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/7/1 20:12, Daeho Jeong wrote:
> >> On 2020/7/1 15:04, Daeho Jeong wrote:
> >>> Actually, I want to keep the mount number remaining to the same
> >>> number, even if it's re-mounted.
> >>
> >> Then once there is f2fs umounter, the order will be incorrect...
> >
> > Actually, we prepared this patch for a strictly controlled system like
> > Android to easily access the sysfs node for a specific partition like
> > userdata partition using a specific number.
>
> I'm not against Android defined interfaces, just be confused about the
> behavior that does not fully documented (at least, we should add this
> into f2fs doc, and specify this is android specified interface), somethin=
g
> like once one mount point was umounted, that sequential number @x in
> 'mount_@x" could be reused by later newly mounted point, it breaks the
> description: "in the order of mounting filesystem".
>
> > In this system, we don't worry about another unexpected f2fs umounter
> > interfering in between unmounting and mounting a partition.
> >
> > When we are under the condition that we can keep track of how many
> > times the userdata partition has been re-mounted, we might as well use
> > the original partition name like "/sys/fs/f2fs/dm-9".
> > This is for when we couldn't do that.
> > .
> >
