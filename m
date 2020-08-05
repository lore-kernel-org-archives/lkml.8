Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894E62245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="G2U85/Sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgHEHnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHEHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:43:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85AC061757
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 00:43:50 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so2072878edk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7MS/sDmqsu2UeEHE/y1WIBOLGRyoL/hTSKDaerW230=;
        b=G2U85/Sh33+IcIW0dxhFoe+oW0YUFI67TOMZGh5yXHDRtVNTTIES6+/5ghbYizPlrA
         NxqWRNYE+WiZQ5x/6V5NBGxTNuIsiyaYdE1+DK4um+EutgPdxUhLgshYgl+AqycDH9vs
         4dvJRUCTUHLDjtWW+GCIgH/TbkBbaYm/yDD6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7MS/sDmqsu2UeEHE/y1WIBOLGRyoL/hTSKDaerW230=;
        b=K0yR0n3BQc5xawG5vrTg2Rhg+dbHdz38tFIGvybR7HOy77FbA9TP/EqNbBGcoh1qJU
         tfpjsAVCWHvulxJrHlvflskf3IvDwNZFixq19KiKz8U6GxB/Sx017ObPBb8V0F50gL+0
         TJEd0poJNXBvEDv/YH2/WKbKZlVxdkSIA8qNcamDDiFny0NYYT1no63gcLXF08DUqxYx
         hMDNg5aGY/j9ceG0RWzT8/FzDMnop3WkSyaBsb1ozvA0BPzYg49w12s8sNPi9HSUWAHu
         Y1l4qpRW8PIFWgzVBxE6rrE1ogM7XSf1N+odUjmq83BSqpekCTIn+u1/cenIO6v8hKy3
         4/NQ==
X-Gm-Message-State: AOAM532ewPsPhe8W+pvybIONP1KixlkQphDf1vhniFPEB4gsHYdkl4jK
        8l7bFBtf5IifNgHkQbINb9n3rU0xqWi2VhiaHR7RBA==
X-Google-Smtp-Source: ABdhPJxB/evMZ5+0ZnmBx4YzSXoXDzPSNs9Cjc++wXkfuUDJKvalsR0eiNz5UMmlIUDOEP5Cy96B5iGq/jW2A8IePJ4=
X-Received: by 2002:a50:fb10:: with SMTP id d16mr1638111edq.134.1596613429317;
 Wed, 05 Aug 2020 00:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <1293241.1595501326@warthog.procyon.org.uk> <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
 <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
 <CAJfpeguFkDDhz7+70pSUv_j=xY5L08ESpaE+jER9vE5p+ZmfFw@mail.gmail.com> <c558fc4af785f62a2751be3b297d1ccbbfcfa969.camel@themaw.net>
In-Reply-To: <c558fc4af785f62a2751be3b297d1ccbbfcfa969.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 09:43:38 +0200
Message-ID: <CAJfpegvxKTy+4Zk6banvxQ83PeFV7Xnt2Qv=kkOg57rxFKqVEg@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 3:54 AM Ian Kent <raven@themaw.net> wrote:
>

> > > It's way more useful to have these in the notification than
> > > obtainable
> > > via fsinfo() IMHO.
> >
> > What is it useful for?
>
> Only to verify that you have seen all the notifications.
>
> If you have to grab that info with a separate call then the count
> isn't necessarily consistent because other notifications can occur
> while you grab it.

No, no no.   The watch queue will signal an overflow, without any
additional overhead for the normal case.  If you think of this as a
protocol stack, then the overflow detection happens on the transport
layer, instead of the application layer.  The application layer is
responsible for restoring state in case of a transport layer error,
but detection of that error is not the responsibility of the
application layer.


Thanks,
Miklos
