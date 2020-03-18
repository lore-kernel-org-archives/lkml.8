Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A1C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C12076A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCRHTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:19:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:56307 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:19:04 -0400
Received: by mail-il1-f200.google.com with SMTP id u9so13482351iln.22
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 00:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AhaXelTb4CkDuWTiPyTo3C6D6QQ6q7mstwM/dklynRM=;
        b=UmJI9rFrD+V4FKCtZy1XEkH0/jXoLgIzPKqYwCto04TPD3EpMdNgQcWTurGSfaqdbh
         q1MR0JGEliCbP0lGBzFzLNvQXZSaFSDrVtOe0EStcIiJv5iVreiwizq4Ux6elgKtIsRn
         IQhoAqndemiGzaQvYnUTHPH9iyEYRv8Qc7P7WK51aSC8ACPdTPI/TkmjPAxkh6kx2b2D
         f4mMLI8J1apEEDo5nGTiFi03rlq6yCNbHvEUyhe5zdjJQH+1427+KEMIwCb5KA8O5PHY
         DW6sAUmHOz+ClY2ghSQlf2o/pIQ/EKiO5yU4wOoLwzJPnpbZ+tmw8+iMKArW4elHSFyz
         RFyg==
X-Gm-Message-State: ANhLgQ00mcALECR7VcFRYuBg0D3FDWIAI3lLTr5KMLTImdqmB4TQ5/EV
        1wi0s0mE7euIKGDmgjbB3j7qsGiOe+T8PhRT+fO0F84PZK0n
X-Google-Smtp-Source: ADFU+vuXK52KHuMfmWijNinm0A+H+Z1mmON3xD7KqXvwSfekdWJ6PLmyjoWTtC0fVh7NoCYO+AVnsxlcmnTlynOwKfHZTfC72zP6
MIME-Version: 1.0
X-Received: by 2002:a6b:c045:: with SMTP id q66mr2517997iof.10.1584515943764;
 Wed, 18 Mar 2020 00:19:03 -0700 (PDT)
Date:   Wed, 18 Mar 2020 00:19:03 -0700
In-Reply-To: <CADG63jBhCBf6r8vfT6kCwh7shYHKsuGH=Mx8D+hDxO0C3Urjqw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f81d5b05a11bddac@google.com>
Subject: Re: WARNING in idr_destroy
From:   syzbot <syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com>
To:     airlied@linux.ie, anenbupt@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com

Tested on:

commit:         b1289238 drm/lease: fix WARNING in idr_destroy
git tree:       https://github.com/hqj/hqjagain_test.git idr_destroy
kernel config:  https://syzkaller.appspot.com/x/.config?x=cec95cb58b6f6294
dashboard link: https://syzkaller.appspot.com/bug?extid=05835159fe322770fe3d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
