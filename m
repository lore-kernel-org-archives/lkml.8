Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709BC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5144820663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCSIS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:18:27 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42062 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgCSIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:18:26 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 02J8IPaV021671
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 04:18:25 -0400
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 02J8IKoM015850
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 04:18:25 -0400
Received: by mail-qv1-f69.google.com with SMTP id d2so1978543qve.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 01:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=EQ73z6kyR/mYMiKdZ6uBkObCrQL0cwEBtzhgaFx9xVo=;
        b=bHck6UclLogWmQFVL2xF9xSiEyH5A4SyV1xOJ3ELsSfr98EYpMQKYOkBtFVtYnLVqn
         JMzeSLd3cLeqoJpXBDQ9dSHVEp9FyCtnrmo/lvp1coPa/uiaE74wDaw4BLvlRgYWgF8Z
         SytMPFFqeVgkpsunNvthIEHQszVvyqTqo9DERoHbrhQuiPTcjk41Wley/DqT2szBXHwb
         +dOEhazTNYhR6+O1NmBcQ3Uo85xsvb3nyoo2I40RMW0zzcAb8Wfw+6RPacT5c50+Fngs
         ncg03NBoCWZ78f/0Qt8/Xic3oJw4Ep8WOLabsETWRdIMH6oQsY/yvHf+p6mdxSgf8/qn
         Dymg==
X-Gm-Message-State: ANhLgQ1ECLnGH337F83f16tOC+06rIi8Vx4gsFowE5/XTwU6+9DLPtiL
        72vpRhmxTA7clU5+tsG2SJz9TgqvwGaD9lii39uaj7QEgEKqPdElUfxlNkdW0pmn+tQgKvVpq1z
        SRMGI94fDSBuqJ4Y++hBufI50U3rl/vp9WmE=
X-Received: by 2002:a37:9d4a:: with SMTP id g71mr1727351qke.54.1584605899908;
        Thu, 19 Mar 2020 01:18:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vudnJfwwF5zKIHxg/r6+WX0X5UaOa01b1dIoEjxI9VQIoqDjMqHuMgI/8c8/6Vcfsg9fxbOmA==
X-Received: by 2002:a37:9d4a:: with SMTP id g71mr1727328qke.54.1584605899591;
        Thu, 19 Mar 2020 01:18:19 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d9sm956390qth.34.2020.03.19.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 01:18:18 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH 3/3] watchdog: Turn console verbosity on when reporting softlockup
In-Reply-To: <20200319080156.GC24020@google.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com> <20200315170903.17393-4-erosca@de.adit-jv.com> <20200317021818.GD219881@google.com> <20200318180525.GA5790@lxhi-065.adit-jv.com> <20200319064836.GB24020@google.com> <16373.1584603506@turing-police>
 <20200319080156.GC24020@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1584605896_13116P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Mar 2020 04:18:17 -0400
Message-ID: <19150.1584605897@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1584605896_13116P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 Mar 2020 17:01:56 +0900, Sergey Senozhatsky said:
> IIRC, CONFIG_PRINTK_CALLER prints pid when printk() caller is a
> running task, and CPU-id otherwise.

Ah... so it does.

#ifdef CONFIG_PRINTK_CALLER
        u32 caller_id;            /* thread id or processor id */
#endif

I haven't seen it output a processor ID yet, so I didn't know that part...

--==_Exmh_1584605896_13116P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXnMqyAdmEQWDXROgAQJeZRAAouGeHvFD/lFlepWbx9gLHV7+BslVrFPo
AyYTgBHDh7YQ8D1XavW4ROAmzhl0e3fR9lH+o88kjdo/Rlz03NnLyB6e/yzoOyqJ
hrOWg1+R9DbkElDjc3Whiidw/AWLBj0IThF8WkTGTo+iWaU1t8OzwjGM3UuchEx/
JlO5iG+7Ae+JWxFtN4hZuzU7FHzr+ULNQt5oUwP5AhaRuTbUnFzkVch+Xhu9vVG9
qjMzpZWOqb6yWsEJTCw7lupiahcUaiidft3eqOf+N8m0q/ul0SEgFzc+wuOh+srm
6O/EMlXmoFakRWvrHB1RlG4+E+8xh96L83oYQjTcGTO7teA6MNGdk5xAyhmWCe0S
5lXFfUUGQ3SoLa+Wm0C+IFgrZ1gmbLgLpTyB2pT2s8LkzDw7EWtzXbR4QkD/PSAB
fAN5hfbAASX5eNUnnlAYBGvz4+TRf2afJl6Fxoz1+l3Fv7qJiRt36Oj3BzMntSA8
0kOIk6FHfTp+n41C2rZiRyMhdoIZt2uAVjWAFw/+kL7gXKPS6ES6D3pM3pIvIEmi
geKg5l8jhpc4vPknvRmVAci1LsJCiy2vX4oapPh3gSBVDTsk9+r8Lrvri1kTfHCZ
eyxbNBGHio9q6hJV16YABOQUCbGKrA63RXFwQWUQXqJPs/kW6n/nXtL9LnnElhwT
Z7CewKdwmtc=
=wBgL
-----END PGP SIGNATURE-----

--==_Exmh_1584605896_13116P--
