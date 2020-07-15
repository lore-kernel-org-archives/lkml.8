Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA102C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A467620657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pErLhR4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgGOFuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgGOFuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:50:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39ADC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:50:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f139so4098644wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v9XpoCRErdQKlje05DdI9K8GPmjX+TCTG9yW8JIzc6s=;
        b=pErLhR4HgD3IKP7X/yDYv8kJ7YXjEB6T9EUOW4DRawm+guQh6l1q/2c1IfUCM8bBc5
         TiEbgnrwBtZsUcT/W5IQL3N24Yx9rHT7yjhhuVfoNgeW7ZiMDAUIZlieq+WQIK/CgaZQ
         Ab/Hu+jXrP1MnjbeaLGXRRoy2ZPuYTi2SqZmEFvede8j26OTmSnWHGfaJyUPl40kl48r
         ncgpMP/8dq7+R3oKVsUSbhDLDAgfbw0sRoe+/j1Z13b8B4gO6IFwGuwI83EiEhOEwvXb
         H6MKpQLVaQ/afX03PplzhgypYAN3K45zTAyO2OJU3Vu4Cx9vwseltCt7JWRAMAQmG2o2
         B/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v9XpoCRErdQKlje05DdI9K8GPmjX+TCTG9yW8JIzc6s=;
        b=e+8u3vASdHrfvp2pT6ch5AHquW4dByQcbjS05M9XWe/6K51cLgZehwiHd4vGmb4woD
         SWcmeE+Zm4YjueRfa/FapZAw/sYvTNuER96PcE8AlM0A1H9WcB6busbBvImGpCAAN3Sq
         zyRXScsdRtRpAOSNqy9cY1/+nPEwzUwBSPF8hzPXMRe8DyW6G3koVEO6XXz8fuVP4N6d
         y2sqJ7HcKad49myrQyJfPbtTWUHP0nZ16q+nCKpZVr5X/hZDAgTMyMsYPDcbV3VBkMzx
         7c12asviTxlBc29wE36tg+hBeH8w1eb1VonIOcMe9j6IJoP59gjbnInH6nM6/k52Sbyh
         Nvgw==
X-Gm-Message-State: AOAM531rnsUhdfzvKg3HLL7WvZ+6HnG/JxWGY3B0WrNX8PRP6JSDZrZy
        e/DOl1B4oEweouxJpP9XX5c=
X-Google-Smtp-Source: ABdhPJyqyGRvwzyVsAs1Mk8/SBEm3V+AqEwb2wYIm/O2wBiEA0tk4WPA3hU3RYUmR+dg3OzxgQcHaQ==
X-Received: by 2002:a05:600c:2483:: with SMTP id 3mr6845792wms.120.1594792217594;
        Tue, 14 Jul 2020 22:50:17 -0700 (PDT)
Received: from [10.11.11.4] ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id s8sm1743728wru.38.2020.07.14.22.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 22:50:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Bug Report High CPU Usage events_power_efficient
From:   Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <20200708092848.GB405531@kroah.com>
Date:   Wed, 15 Jul 2020 08:50:13 +0300
Cc:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B525BA20-4B39-4B31-9535-28A93C5B8332@gmail.com>
References: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
 <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com>
 <6AD52867-83C1-4C6C-A0AE-4DE0D6C16310@gmail.com>
 <C89D167C-E03F-4116-9647-F50607DF3A45@gmail.com>
 <20200708070912.GA351187@kroah.com>
 <CALidq=UYNMxLQTT_D=EOESUxr82LYH04YCjT6igwqdnw3YwyiA@mail.gmail.com>
 <20200708092848.GB405531@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=20

Oki i find the problem is come from nf_conntrack_core=20

I isolate problem in this part :

queue_delayed_work(system_power_efficient_wq, &conntrack_gc_work.dwork, =
HZ);


When package go to queue delayed in one moment if connection track is to =
big process to delayed go to lock and start high cpu load.

This is need to check and find solution=E2=80=A6

For now I remove queue_delayed_work and wait to check machine and will =
write status.

Martin

> On 8 Jul 2020, at 12:28, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
>=20
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> A: No.
> Q: Should I include quotations after my reply?
>=20
> http://daringfireball.net/2007/07/on_top
>=20
> On Wed, Jul 08, 2020 at 11:34:52AM +0300, Martin Zaharinov wrote:
>> Yes i search but not find any information.
>=20
> Please do the testing yourself, using 'git bisect' to find the =
offending
> commit.
>=20
> thanks,
>=20
> greg k-h

