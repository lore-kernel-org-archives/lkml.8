Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A7AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C1820707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA3WPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:15:36 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54928 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgA3WPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:15:33 -0500
Received: by mail-io1-f69.google.com with SMTP id r62so2867280ior.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=+k7iDP+b+RSppJNVffwutaADbltSwq9ahKvDsUQFSno=;
        b=Po2T2MXg5xYNEGfynp77bf72pKgscxfpV0DasTWpxUHcazAmOlYhj/ApTd/MldYc4s
         XGxf0Gl6VYkNO2LN0d0YnTBW4vModyZE0FHf+3JLmvP82oXDPX5gSxBgH0pKI69xSkri
         LX1WgLCbhn2ijCbZT0KUioSAFdXxizn/bjiyXxLz/Y/+iOdb5BDa5bJUOD66jS6fmmez
         tRbeU+XSkOyDU2thyi84V1MGWapQcDZkaAR05k519hIOm8q98HLbBpg6bekRjbGdRM0Z
         L2AX/DkpcbU4kBOTH6AkmpsRh+TfB0DjqNyvtxGcEP8pnvRVaKegEjCRi2u1b57c9CuT
         f6ww==
X-Gm-Message-State: APjAAAVbMqfkSBkSpT1VFHuaHFdB8hw+nCs1Wo43OLgvlS+i/r54zJA8
        6IFAqjTrQC1uSEJmVvBBA1GpBvakUY1RQa4N/ZFKRI5XPZZf
X-Google-Smtp-Source: APXvYqzCBZ/4ytbfQ/bruKEWdSfGIalMqVxY1nmEN/PfITi1/h8RpCDn5XQ2z28pfaS1iyaRrIPuWw325giOjT+XycQu/RjlaEmK
MIME-Version: 1.0
X-Received: by 2002:a92:8141:: with SMTP id e62mr6399121ild.119.1580422531620;
 Thu, 30 Jan 2020 14:15:31 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:15:31 -0800
In-Reply-To: <3725016.1580422520@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097a7d3059d62cbd4@google.com>
Subject: Re: Re: KMSAN: use-after-free in rxrpc_send_keepalive
From:   syzbot <syzbot+2e7168a4d3c4ec071fdc@syzkaller.appspotmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     davem@davemloft.net, dhowells@redhat.com, glider@google.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git e4866645bc264194ef92722ff09321a485d913a5

KMSAN bugs can only be tested on https://github.com/google/kmsan.git tree
because KMSAN tool is not upstreamed yet.
See https://goo.gl/tpsmEJ#kmsan-bugs for details.

>
