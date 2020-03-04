Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9056820866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAlQDt3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgCDOge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:36:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39004 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgCDOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:36:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id j1so2111030wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTzQt0c8E2G6FZcIo18SJrDWTb5FVlLb3zKNZ55nIjU=;
        b=UAlQDt3yXzhr1/Rlios7rnu8wu2dcEdNDRjne6mXF68TpoDeVMd80MArY6GgTG0o+h
         eeRgrqZAwiSTKJFNqNMVUGYca3sMWZcDXfhfqeoQGKmJwTdSONAYepcnIPU431ZdwBti
         H1TWcZZ3+JCr+9iuwAAmxXK+eRMDHht/RoggLD1iTWBXi8lXfUE4etVlHlu1IaPXfk9R
         sBmPPzWC3vyUAz0KT/tUM84vO19UR79dRW/ElIsVaIS60KGvKbeIxSnZ/zyfqrLyvx6I
         7PJNDvgKCAxIdUggDa2GpVHGOy2m9GIdp4xiZ8/HTimBbfPwNyezGZSZIzhQCaX0WJn0
         l14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTzQt0c8E2G6FZcIo18SJrDWTb5FVlLb3zKNZ55nIjU=;
        b=V6F2zidCmcrB1J/6S9Ix2TzYEHMsxpqZeGtSndoNKnCV9sp2O2/q+0JKgIoq6rVG7Y
         CfIezbPCdDq5vkQcVA4d/JDdNUleIGtxmawY2ABeU4m1QYWJ9hQuPY+LzqV46d3zhTFA
         OMpaOqzsc72jnRiBuuv4JGaKxE+9WFcjY55UAqN08SKC+m72YY8kzbqmcRy/L6cNqCBi
         v/JUndZHkqM+RTA780gy2hfl4cNyKOxr5YYdh8qRDAxGNHEX1Q2TrnYlAbu6UK5fLfbJ
         hkly1XLy9DT8R6C6CvM8o9dWhGiVbIqEFxWqZMAXbbxCZ4qztfcKbsbMp/yCP8coOqE9
         Pccg==
X-Gm-Message-State: ANhLgQ3qzdeswvhG/EJDmFlK8n1e3O9yq+pSxL/SRdXdYXcaBa5xtCBf
        mibYYZk9lyZXRZak/vOpwD7H0zGA4HicKfd1jmugPg==
X-Google-Smtp-Source: ADFU+vtpj9M0/D5qC5k2fYKUXJ7T8fvjXg9+pLPrkkl6qnlX0K21QBOgi8n2/aKZZLKMXiH5E/H2EvEi9HcpVdIwjdc=
X-Received: by 2002:a1c:238d:: with SMTP id j135mr4057772wmj.165.1583332591534;
 Wed, 04 Mar 2020 06:36:31 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b25c1059f8b5a4f@google.com> <CAG_fn=XWOjiLY8KON5VdieOVpWdnbtMqo2v8TZ1f04+4777J=g@mail.gmail.com>
In-Reply-To: <CAG_fn=XWOjiLY8KON5VdieOVpWdnbtMqo2v8TZ1f04+4777J=g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 4 Mar 2020 15:36:18 +0100
Message-ID: <CAG_fn=WvVp7Nxm5E+1dYs4guMYUV8D1XZEt_AZFF6rAQEbbAeg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in simple_attr_read
To:     syzbot <syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="000000000000aeadcc05a0085848"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000aeadcc05a0085848
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Rafael, Arnd,

> This report says it's uninit in strlen, but there's actually an
> information leak later on that lets the user read arbitrary data past
> the non-terminated attr->get_buf.

The attached PoC demonstrates the problem.
I am not sure how bad is that, given that /sys/kernel/debug is usually
accessible only to the root, and simple attribute files don't seem to
be used anywhere else.

--000000000000aeadcc05a0085848
Content-Type: text/x-csrc; charset="US-ASCII"; name="simple_attr_read-leak.c"
Content-Disposition: attachment; filename="simple_attr_read-leak.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k7dfc2n10>
X-Attachment-Id: f_k7dfc2n10

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8dW5p
c3RkLmg+CgojZGVmaW5lIEJVRl9TSVpFIDEyOAppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJn
dltdKQp7CiAgY2hhciBidWZbQlVGX1NJWkVdOwogIGNvbnN0IGNoYXIgZGVmX2ZpbGVuYW1lW10g
PSAiL3N5cy9rZXJuZWwvZGVidWcvYmx1ZXRvb3RoLzZsb3dwYW5fZW5hYmxlIjsKICBjaGFyICpm
aWxlbmFtZSA9IChjaGFyICopZGVmX2ZpbGVuYW1lOwogIGludCBwaXBlZmRbMl0sIGRmc19mZDsK
ICBzdHJ1Y3QgaW92ZWMgaW92OwoKICBpZiAoYXJnYyA+IDEpCiAgICBmaWxlbmFtZSA9IGFyZ3Zb
MV07CiAgcGlwZShwaXBlZmQpOwogIGlvdi5pb3ZfYmFzZSA9IG1tYXAoTlVMTCwgMHgxMDAwLCAz
LCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCk7CiAgaW92Lmlvdl9sZW4gPSAweDE7
CiAgdm1zcGxpY2UocGlwZWZkWzFdLCAmaW92LCAxLCAxKTsKICBkZnNfZmQgPSBvcGVuKGZpbGVu
YW1lLCBPX1JEV1IpOwogIHNwbGljZShwaXBlZmRbMF0sIDAsIGRmc19mZCwgMCwgMHgxLCBTUExJ
Q0VfRl9OT05CTE9DSyk7CiAgbWVtc2V0KGJ1ZiwgMCwgQlVGX1NJWkUpOwogIHJlYWQoZGZzX2Zk
LCBidWYsIEJVRl9TSVpFKTsKICBwcmludGYoIiclcydcbiIsIGJ1Zik7CiAgcmV0dXJuIDA7Cn0K
--000000000000aeadcc05a0085848--
