Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63143C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9BA206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZtRsZCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGACrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGACrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:47:12 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 19:47:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id e12so17328567qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 19:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=65Lb9qUYvL+TtRCJQNaCYe75zyZB0A/F6ddO/rGUvVs=;
        b=RZtRsZCs1NDJAch4MibIDogGxCGQvAVPwfIHcrRuJIotG6759I+5sb5Nw6ONu/13sf
         cfXTsZsL7tUU5zzksQrfhbsLFcJ5GaJD0xyU9ROGwFZ7dvl7Z+zI/Qn/Zf5PpUlxy5wY
         bO8+faJL4CmxZIfgJpAcADgax9RAkisuXhyVoU3jKKzPWNvcvPvFolBkn7+ua1YYB941
         XDrVhcCEDGRz2PSSfliQBQvLeNvrbXf7TA2CxY4EGJXycCtmyxhYuQTkgv00k78x6KDZ
         Jv+OVeks56wS9/VLYufFbE67AHxkaXo/nMOjc+yMzGfiERNDWHzATH+DcEUoBzs0vm2i
         MFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=65Lb9qUYvL+TtRCJQNaCYe75zyZB0A/F6ddO/rGUvVs=;
        b=aAnS8FQzeGe6A+Ve1z5cupULNSiru/Y2MUSltTfHE0NP7qjQtE5r+Qf7A8ZSJQZPUN
         Dn7A8V6QXnh1uK/361CvLJLP6YsI39yrolb3KBKkYF35XAKScseDKYnNTuGDlYVbafL4
         Yw3yfGNJu6cpU/OHWMfNWW2EvbhBNTjibrtPao2zJOwpjyOTXJq4xrVKaKX7vyJWP/2d
         INaV+YrnhkhMOzx3nGFRypLPskVQwWeQuCd92ulOMAETwidbCg1BykVH+8EFnndS6c3l
         s7DlljCFVzjssqbkB2pPlzJL90PelHZ4TKPOytQAbnqKBO3bO8hGjUsFAfAgLO3a8CCI
         YVEg==
X-Gm-Message-State: AOAM530GyzAZ+nwLmPf988niduuYnoxeatVMYfd3SKFceoDS98CZnqsK
        mO2Xd1Yf8iNspxt5oJgr3D2zWH6HDALvvsAy0XJQ/BaOyV6rFg==
X-Google-Smtp-Source: ABdhPJx+prB+JwxfK9FgPokdDAhqqWoWVFK/HRqfv5FRHMJYn/18hANIOuZJZB6wV8CO60y/O6o8mNdqKUidA/8fbDE=
X-Received: by 2002:ac8:172e:: with SMTP id w43mr12978532qtj.8.1593571630514;
 Tue, 30 Jun 2020 19:47:10 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Wed, 1 Jul 2020 10:46:59 +0800
Message-ID: <CAAvDm6awRF3J=sn-bZ1FO-JzuEAhcBvb66ev7=5BB2YracCgWg@mail.gmail.com>
Subject: How do you investigate the cause of total hang? Is there some
 information that I should pay attention to in order to get some hint?
To:     linux-kernel@vger.kernel.org, Kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, list

My x86 machine(linux4.19) sometimes hangs, suddenly not responding in
any way to the mouse or the keyboard.

How can I investigate why it hung up? Is there extra information I can
find for a clue? Is there anything less drastic than power-off to get
some kind of action, if only some limited shell or just beeps,
but might give a clue?

Thank you for your attention to this matter.
