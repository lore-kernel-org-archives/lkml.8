Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C9C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 06:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7C8206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 06:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDDGOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 02:14:08 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:36796 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgDDGOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 02:14:08 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 0FE2A12F211;
        Sat,  4 Apr 2020 15:14:07 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-18) with ESMTPS id 0346E5Hb047956
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 4 Apr 2020 15:14:06 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-18) with ESMTPS id 0346E5xb200873
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 4 Apr 2020 15:14:05 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 0346E2M4200872;
        Sat, 4 Apr 2020 15:14:02 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KCSAN: data-race in __fat_write_inode / fat12_ent_get
References: <0000000000000cfff005a26226ce@google.com>
        <874ku0sncc.fsf@mail.parknet.co.jp>
        <CACT4Y+YaM9Qj9V9G7G+aQrmfxfdtyBX4WXXsBamUjyMMpEeEdg@mail.gmail.com>
Date:   Sat, 04 Apr 2020 15:14:02 +0900
In-Reply-To: <CACT4Y+YaM9Qj9V9G7G+aQrmfxfdtyBX4WXXsBamUjyMMpEeEdg@mail.gmail.com>
        (Dmitry Vyukov's message of "Fri, 3 Apr 2020 18:36:26 +0200")
Message-ID: <877dyveq1h.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Fri, Apr 3, 2020 at 3:36 PM OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp> wrote:
>>
>> Hm, looks like the race between a directory entry vs a FAT entry.  This
>> bug was happened with the corrupted image? Or the image passes the check
>> of dosfsck?
>>
>> If the corrupted image, it may be hard to prevent the all races. Well,
>> anyway, the corrupted image of the report will help to detect this
>> corruption.
>
> From the log, it's this program.
> My bet on a corrupted image. syzkaller does not have format
> descriptions for fat, so it's just random bytes.

You meant I can regenerate a disk image from that log (if so, how)?

If not, for next time, it would be helpful if syzkaller provides the log
to regenerate the corrupted image (or saving a corrupted image) to
reproduce this, then I can try to detect the corruption pattern early.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
