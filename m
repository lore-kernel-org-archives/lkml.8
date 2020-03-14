Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC7FC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A7C206FA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHpwNfRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgCNCyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 22:54:24 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45172 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgCNCyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 22:54:23 -0400
Received: by mail-ua1-f68.google.com with SMTP id 9so3911210uav.12;
        Fri, 13 Mar 2020 19:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fN3JrJduGVoRbK6wDD/9QZeeqstuQUcSJUGOtyl6ySE=;
        b=GHpwNfRaQDA2jJ+Xmki2C1NPLLWcym7VlAn8kcCalMNouxTZFPK2CiNJry5ysIpYqo
         ZmAxp6XD+v0hWucPr1l2/Gj+AP31grjJ0ui7PbDtyIypI4YBdEvNGhnWiQMDhPqVCgsx
         OTBYhbh8EY3OfKGNTnr0Fh1UcabsrA3tedW8f0HHU1mx7C/7L2eXcg3JEXik0gQ3S1ry
         H48JsGcf9/7cersV/wlWGVzEsG1jdmznGpLNDfJv8r9nzqix7NtyO4bCFc+LKqm51nVk
         qzBdOxetC8za8um1QAy0Icn9jlFmoIBkcGxD8kK0HUc30+e9G8r02PKBQUlyOYAT/KR8
         x1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fN3JrJduGVoRbK6wDD/9QZeeqstuQUcSJUGOtyl6ySE=;
        b=AaknDT/3ZO8Q8ZHmtMGONT1MMGlV4RX3Vfij/kdsXxDk7RxL+YpN/ZnkcvWKLo4+vO
         EtGdEMC3wMx96GaxjO+rjaFTBaHyXH3+ZZMI4T/hhTMJs1Q1v6bYr/FvpfhdEYtUt89O
         02VkxTXgFgKF547CGHvthEnlJ0ghM8fcTQjqdKEkwCRbLeOAjPTBOMtUf17TImEBrSkj
         rvCsHHbYmA1SxEW8YYUMcm9M20PVoYPI6HX51BHS1/kvjhvnCIhHuy7T4Ke3ivyLvcJj
         J/tVWdHQDNGjgxeeu9id8HTLGuwvNH7HgHF5Ef6oX52luL3dQ+RSidH1EWUNMN7OPe3a
         On7w==
X-Gm-Message-State: ANhLgQ0qaPMKMKgbLCZ6z7djhYAFZ1YYS3Ve5s03d4YayGLC5yAqN30B
        9JXQs45PBjAZAswywiNW70P7MVVu3TeyKcxxWfo=
X-Google-Smtp-Source: ADFU+vsc5YOy/6GCjM2TSFcuwhzswZoMQiQxdeRIFbDwsdaxEKt325QmBLCBRrpGTKB0onErKPaCiUeTDDtDL9LdzVs=
X-Received: by 2002:a9f:28c5:: with SMTP id d63mr2756669uad.25.1584154463028;
 Fri, 13 Mar 2020 19:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000088452f05a07621d2@google.com>
In-Reply-To: <00000000000088452f05a07621d2@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sat, 14 Mar 2020 10:54:12 +0800
Message-ID: <CADG63jCSHu7dQ118GEuhXBi0H4CW3cBqB5F2qKiyeVzNb0U+wg@mail.gmail.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
To:     syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/hqj/hqjagain_test.git scup_wfree
