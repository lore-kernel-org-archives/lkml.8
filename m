Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CEAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5D820714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCQJnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:43:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40468 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgCQJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:43:04 -0400
Received: by mail-il1-f199.google.com with SMTP id g79so16432893ild.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PW0GQblWV2FIRNcAXaN8lnlKSo1FObe24H+vNCUDKng=;
        b=pJEN2jdPFeKu+wLMtqEydogL8deMUz9LE2JpajUsYeLzMcrm6icqVizyCs662tFW+B
         U0C9s3vkzrftR5tUf7I7KkTj5OlkTzmdV/o0WkRMYHsjDsHPhdP0ZbfCQctb6gkkXoz4
         B+nR6+9ngr+tP1ikJbvZ80dhDhoAihjFHevHb5+CP0/kDtd8Nz4cyaAYN3daeFkqYCmK
         SO712moVdr64JvoDharNcYUutDCBRivNJ0U3k3o5Sf3Nb3w18STP0319FIWDiTfD8sRd
         KMEM8pjeSHSh3QOnJFcnBhLYSRM/O88rU/x/xB060iURT0wvr4gnUJ5WdwDDSJFxTMS5
         bwVg==
X-Gm-Message-State: ANhLgQ1cviAwOrNq9w9xUMRDOLRhxPp9nR3pI2zyyYJDNLld2WBSh6J6
        zLnjQuNl8gYb7G7vTozsBKeuVh00xU15qXb6VksG/pCrrIDi
X-Google-Smtp-Source: ADFU+vvIfdh+VHjIocKoF/NnoN2g0GIMrZ+pScXE2yFVr1HLQuuVph7/qU+bp0w5KD4kBLw12fZaVNa3kwzBUDk9FcuKD1rVTzov
MIME-Version: 1.0
X-Received: by 2002:a5d:93c8:: with SMTP id j8mr3217898ioo.72.1584438183273;
 Tue, 17 Mar 2020 02:43:03 -0700 (PDT)
Date:   Tue, 17 Mar 2020 02:43:03 -0700
In-Reply-To: <000000000000fe6c39059905c289@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001529fb05a109c3dd@google.com>
Subject: Re: INFO: task hung in flush_to_ldisc
From:   syzbot <syzbot+e199b43b49192126ff69@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hdanton@sina.com, jslaby@suse.com,
        jslaby@suse.cz, linux-kernel@vger.kernel.org,
        okash.khawaja@gmail.com, samuel.thibault@ens-lyon.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit e8c75a30a23c6ba63f4ef6895cbf41fd42f21aa2
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Fri Feb 28 11:54:06 2020 +0000

    vt: selection, push sel_lock up

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bd23e3e00000
start commit:   07c4b9e9 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=e199b43b49192126ff69
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4efdae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ccf946e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: vt: selection, push sel_lock up

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
