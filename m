Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C557C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AD320722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCSHip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:38:45 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41896 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726063AbgCSHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:38:44 -0400
Received: from mr4.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 02J7chLI031441
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:38:43 -0400
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 02J7cbVY024147
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:38:43 -0400
Received: by mail-qv1-f71.google.com with SMTP id a12so1889691qvv.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 00:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=LmFAxMO76NO0La6oBWVkJamYtde7uPLbuFYwcxlRUEc=;
        b=Xx00Wj3upN++jRtQoRpEpN8epuR56o1A6o2tLcMRQMdxq+CJ1YbkKZTqAQJn9WVoeC
         YgDcsjkHWK6+VxW6GiTSyHFcJo9gwsIeUbIcAMB59+sXHbwf5p+JPm1Vt5fHanr6f8o+
         hLkJUF2KMYA62az4uqtNu7AMjWto1pGxlJRORfq8s9qBN/b7suNQmBbQsBlpVltvyVmD
         Y4v6qLKCP0XmxpRD7cTjwOv0+f/xcacO1K7Y3uH1rkO7ttK8gxGQwY55auGaMhnS+cJo
         tCV/pQkXASKVfbW07SqrSA+wOMVRR8O3rIHjfzN+u8sHWf2CZjTNVz7DwvLfOGa31TDc
         XY2w==
X-Gm-Message-State: ANhLgQ09zI8r9pG3120Zs22XQRSS11ZKFAZl09dTPcneK0z2YiKQqZEJ
        ZxXLKKpiVACdyNXQotPtDnbgJHnlKrCKj+OsF+Ux3o/3JX2Wov5pRXmDGt9sGGRM60OqkHYr9xF
        NlQ2YbHtFn7FvqqyL1z16fsz+qcdqvMX8p3M=
X-Received: by 2002:ae9:e88c:: with SMTP id a134mr1670360qkg.183.1584603517694;
        Thu, 19 Mar 2020 00:38:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu5nmlZn+ioj/Zt1VHBcBqqR6EtKC1AKYeG5RLTAlqJL+VK8m7il49SUS0scAxOwaRtRIWEaw==
X-Received: by 2002:ae9:e88c:: with SMTP id a134mr1670054qkg.183.1584603509610;
        Thu, 19 Mar 2020 00:38:29 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id u24sm34623qtu.96.2020.03.19.00.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 00:38:28 -0700 (PDT)
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
In-Reply-To: <20200319064836.GB24020@google.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com> <20200315170903.17393-4-erosca@de.adit-jv.com> <20200317021818.GD219881@google.com> <20200318180525.GA5790@lxhi-065.adit-jv.com>
 <20200319064836.GB24020@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1584603506_13116P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Mar 2020 03:38:26 -0400
Message-ID: <16373.1584603506@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1584603506_13116P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 Mar 2020 15:48:36 +0900, Sergey Senozhatsky said:

> So the issue is that when we bump `console_loglevel' or `ignore_loglevel'
> we lift restrictions globally. For all CPUs, for all contexts which call
> printk(). This may have negative impact. Fuzzing is one example. It
> usually generates a lot of printk() noise, so lifting global printk()
> log_level restrictions does cause problems. I recall that fuzzing people
> really disliked the
> 			old_level = console_loglevel
> 			console_loglevel = new_level
> 			....
> 			console_loglevel = old_level
>
> approach. Because if lets all CPUs and tasks to pollute serial logs.
> While what we want is to print messages from a particular CPU/task.

Well... how does this sound for a RFC idea?  We already have CONFIG_PRINTK_TIME
and CONFIG_PRINTK_CALLER.  How about adding an option to allow printing the
calling CPU as well, or just extend CALLER to print [pid/cpu] rather than just
[pid]?

(And yes, I know that the concept of "this CPU" can change quickly, which is
why per_cpu data may not be accurate for anything more than statistical
aggregation purposes.  It's only worth pondering how to deal with that if it's
worth developing the patch at all... :)


--==_Exmh_1584603506_13116P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXnMhcgdmEQWDXROgAQIpVxAAh/dMuQn+/WY3Tf02NolMacc55goAz7jP
wuQz4/9+SseYJBe6eq8bjshKtvexOSEjWwfC2TtuJUDLuLwASqUXaUchGGJs6z5z
bXl0aDmK9jQW8ogcd1S1NZMs3iOqC4e0+Ej3pkWNFiUpvY5hcKar/+w/G/6v80hw
3fF835wFNjGOtsmFBPvvqSjTrDX7QQnfAJ5frFDlMgvgXqKtPqzZUaFJaoUgvOia
gFJb2vbX86ilYj0W/FOax+8EfVLgBUEjTO2/ubZNXRnEykQKVVDL2i6xwTyj4Jk7
cJcCDWwk4oJCTUdTxC6+EcpCZSQB+dqBDxRwhRQZfesnM9g6w88Gc1Gdl+oVlVRo
ktCbwL7+Wy3epQRIO+gNFJm5V/DnElMCNr5ZDviQLGQvS0jiyp4baxt59hitG8De
l09n8V8mRXxQhfy/z8tyQzPwN01OaVB1XR9762BrXJ/sOwNRU8cF5UHtyhGXzEdO
QgIcQIUTnZ6dBr+vA30/NrP2iHvvodguJktXPDZGgzsxAAtNbA25UybM+9rZAEtE
FNka9fKe29GojsGCrSCkgICjO4N0JvqJ2ZXBgvz+4y6cX/7rqf4TXVHxxXgV74kt
BnPuWnduDE9E3qKzhDBdtBAFflQCLg/B33W3DMwvo49C/cLvY11rH+4OvMyPRglx
G8wVW+Un+dU=
=MV91
-----END PGP SIGNATURE-----

--==_Exmh_1584603506_13116P--
