Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F67CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30CB2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7ZK+pBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCRMHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:07:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34385 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgCRMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:07:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id s13so26719921ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xYab8ZW+PzDc+v6CkQlUDWiUUOqkPWlNCzzCEJq5HBA=;
        b=O7ZK+pBCI02kadu9Tg3PJiG8b+B1hbYLAI16gxTbPDPDW/oE47ma/pZ+zAn97+Q0tw
         JhaCTePf0EuSGmRNpq0NGpKmknV7sMTGGz/+/MfLAeNS0A590eZ5gbJ+1I7kmxLrwg5P
         gzMIBq6PsRtNl56wTlY70rAdn6SlcNTN0+G49HMHWHqaKZN6K2Woe6GQJlwk261of23J
         TL2dfE1nCXTStvzZQFQjJZ/Shm3ItQErhvdC96l7P+U81Zb5fcqvvYa0DyUzv4Bj6/hY
         L4UdReiOsLUbj+lr7gSMqZDaoHRJz18yYRZo7Y05GHTBU9N88uJp0mhC71fnRJRj/dv+
         1lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xYab8ZW+PzDc+v6CkQlUDWiUUOqkPWlNCzzCEJq5HBA=;
        b=J1Mq+2UxuMQLRq6WyiCblfaXcrZPe6uUfxDeH5kGyevpxPti3duSKx2wLoTiRgYRwJ
         CKIvMLmfgMDDwu4c9I0MyxmBADFM8eJSJ2mqvXNwYoJ3WVWX7gGELyUBgKayuevs5J6X
         nU7pcMtkxd5//gMu8CMO6+XGC5o96Bn1mUoSG+4trCBhNvY/AmRe7XCW0Sq110xDMkz+
         FOKBs9pEyZwbZvy9y4VLJg9iOxbozy1RZ7TGcGtTRKXZ/f7Yakz67AiTo2OlsUH7lGhG
         ouuTlZuoPPXEZEiHwwAfasOEnfpPkLG2szrhdfFhOh45Wv7PkUDwrEsqBjuwO2oLk1Qd
         WjMQ==
X-Gm-Message-State: ANhLgQ0RzQYWKo6n8WI40OUZicNVEuaE2mB47u7iqZ4e/PFAlmUz0FdX
        zRo4OgtYVaIxgFPa7GbruXg=
X-Google-Smtp-Source: ADFU+vvcRi8/WKUppPguFMSbYMLEM1JH1gassiXBwvucPGIUsaTBMlH+Zng/+OHUfBv72PBSOA84mw==
X-Received: by 2002:a05:651c:8d:: with SMTP id 13mr2123878ljq.256.1584533237368;
        Wed, 18 Mar 2020 05:07:17 -0700 (PDT)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id t6sm3020529lfk.91.2020.03.18.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 05:07:16 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id AB495461840; Wed, 18 Mar 2020 15:07:15 +0300 (MSK)
Date:   Wed, 18 Mar 2020 15:07:15 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] ns: prepare time namespace for clone3()
Message-ID: <20200318120715.GR27301@uranus>
References: <20200317083043.226593-1-areber@redhat.com>
 <20200317083043.226593-2-areber@redhat.com>
 <20200318105747.GP27301@uranus>
 <20200318111726.u2r3ghymexyng5nn@wittgenstein>
 <20200318112814.GQ27301@uranus>
 <20200318115731.3vn7cjchunk2bqoe@wittgenstein>
 <20200318115800.p4rsqua6tglydulu@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318115800.p4rsqua6tglydulu@wittgenstein>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:58:00PM +0100, Christian Brauner wrote:
> > > 
> > > I see, thanks for info! So I think we could swap the members.
> > 
> > Yeah, _if_ we go with a version of this struct we definitely need to
> > ensure proper padding/alignment!
> 
> Input/ideas totally welcome of course!

I'll try to take a look once time permit, but no promises though.
