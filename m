Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B163C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB84D20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ExbNf48T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgENVj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:39:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:44147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgENVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589492382;
        bh=/FZ3cV3VE8e7a6n/84h2tcGA6lWyzBXC2WW7OaIYNCM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=ExbNf48T/Gpd5RcHHAdJ4jgs2gJSD2xXYVr5tGT/wwgoCcon9utSf339KDJYd83rA
         HYLkYMUH8lCzXqRwxPbPTrV3K0OXMV64dj5yWEIymjMQR4NOUif9Rlr35XdrtN4rZ9
         zhFj19l62Q55h+JI7gPrkfWGaSXJVFikY5faNj+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.158.118]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1jaSag1VCW-00Y8nT; Thu, 14
 May 2020 23:39:42 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87bln7ves7.fsf@gmx.net>
        <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
        <87v9l65d2y.fsf@gmx.net>
        <20200513220428.4nksinis2qs5dtmh@linutronix.de>
Date:   Thu, 14 May 2020 23:39:40 +0200
In-Reply-To: <20200513220428.4nksinis2qs5dtmh@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Thu, 14 May 2020 00:04:28 +0200")
Message-ID: <87mu6aurfn.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:9vhhOdjma8C/TBocgEUzfynWpPFVYbfK1QiCa0sypdcWipA/1yH
 PYRBH0HBeSKuY9m4g60LKI9pmR/szrdPxG+gudoBBAYwk0nPIixS7t5f8z5CgREYDHIzTca
 P6MB2f6stk1dT8NLoO24RuB42nPmDdyxtIhiFoJmSKTKsKBfJQRharmLtGWKkQ/K0ZqvGr2
 fe1/MDSGh8vpk7U4yiXzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nH1nDPcMUFg=:4Qlz2zL3IeYwqsJrOy0fpO
 AuDV7LhsBxcPRiwgavHKgxqrZiFaSo8Ro4Y+xMC4dU6xH0W6q7VPTEdiIFkfSCw+zuxJiDV6l
 ivPD/zB3116mE1FPL0alZY7bgWt26do+/4CoGorLi12z4/ulcjfrw1XxUiTi7SwwzLLI6H2xh
 BFLUTWSgztov9OjYa/UA3298/Bm2b/UaSCr49QJkxs2420hnqrBXDm256/yfyRmshAD16wPM1
 nyh9rWz9bgbeGShUZJ2qJ/FbZVuD9OgVnymQsah0nTIbyP/alj9A1GfscEtuCNcNnPc19ElIY
 qVPAT3FxK9yZxFikrHYH6FXja+h1lCOTCNdH8ZGklqq6nwM90i8fmaIAkfN/sqLEfh3ZYL67f
 W0d10DjbrH8mr+tvRgYF4fFkaNTURho8lb4veO+4vtOLwqjXb056GD1AbgKfLPNXKVZbwnVDL
 RBmsWZ619T3dhrUrADpsFNujgPIJDHJn0PahnKzpS/Y/p0TqFQKxVfc/Ut7giHlOoYmEZ1jj7
 BInFJeB43/WvJWYv84jrRlV/XEb4/JrB/UtU/nVPSuGl1kPsE0XlhXqeR02DcetRy+DtDYr1C
 0sLF4DBPTbxGIrxQYB9J4qTr0+OOMlPTNOwRqAivrevCHCFg28wH3W/+vJxxMHBYo1NTf4zJR
 Rf3WK3uMS/EfeNYr+IReSH7Xs4IP5pgsZcz9yCainP1bC7rn1w+lzZp4d6LMlZvm5lNAa+Qsw
 qIIRodT1vQ81drK7wQRLMix1wI14SgsxFPUUp973+HhSlyq9yGN5ag/ORBa0DNbG6lz4jsTH3
 TOdw6hip+ibs1CD2pqnUoz0AFKe+zkjGI/zXQg3pshs1TYmlj/SRQ5XiMq4TDg2jNmlQIFfO8
 VdQSIujdcsh9hv6xPCl6sIf/JkfNmib+EW+1KWNTafGiOsh14sDCLuVnliCtqBs+qFTEr2JxK
 ucCffX08rVfyk/5DNKJX7czaMUuY0S8QqPvwBHCypYLGGq2uuHDuwtNESa73v0OpggYYvu+62
 WHy8pD0IJjXxW9cdsmiNmMISxY2Am2J2nBR1jdC8D5YbIKrOOJ3AOhERlWcMVqu8bSJaElSot
 +q4cZzuFLwOze3+mdXkUTquhk1IKrylfRWtKSI7CdIDE/m0ZnKhZguRAUwB4wYmTW3kkbbamo
 wVmzrFJqIK1AV1wFbLYDwi0FtMOhc5sia28VQ3hE1nRE+K9IgpiwcmKaMmleLDfnyPp89NjSq
 SsbbcwuHl/wqVQJAF
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 00:04:28 +0200 Sebastian Andrzej Siewior <bigeasy@linu=
tronix.de> wrote:

> On 2020-05-08 23:30:45 [+0200], Stephen Berman wrote:
>> > Can you log the output on the serial console?
>>
>> How do I do that?
>
> The spec for your mainboard says "serial port header". You would need to
> connect a cable there to another computer and log its output.
> The alternative would be to delay the output on the console and use a
> camera.

It's easiest for me to take a picture, since there isn't much output and
in any case the delay happens on it's own ;-).  I'm sending you the
image (from kernel 5.6.4) off-list since even after reducing it it's 1.2
MB large.

>> > If the commit you cited is really the problem then it would mean that=
 a
>> > worker isn't scheduled for some reason. Could you please enable
>> > CONFIG_WQ_WATCHDOG to see if workqueue core code notices that a worke=
r
>> > isn't making progress?

I enabled that and also CONFIG_SOFTLOCKUP_DETECTOR,
CONFIG_HARDLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK, which had all
been unset previously.

>> How will I know if that happens, is there a specific message in the tty=
?
>
> On the tty console where you see the "timing out command, waited"
> message, there should be something starting with
> |BUG: workqueue lockup - pool
>
> following with the pool information that got stuck. That code checks the
> workqueues every 30secs by default. So if you waited >=3D 60secs then
> system is not detecting a stall.

As you can see in the photo, there was no message about a workqueue
lockup, only "task halt:5320 blocked for more than <XXX> seconds" every
two minutes.  I suppose that comes from one of the other options I
enabled.  Does it reveal anything about the problem?

> As far as I can tell, there is nothing special on your system. The CD
> and disk drives are served by the AHCI controller. There is no special
> SCSI/SATA/SAS controller.
> Right now I have no idea how the workqueues fit in the picture. Could
> you please check if the stall-dector says something?

Is that the message I repeated above or do you mean the workqueue?

> Is it possible to show me output when the timeout message comes? My
> guess is that the system is going down and before unounting/remount RO
> the filesystem it flushes its last data. But this is done before issuing
> the "halt-syscall".

The entire output from `shutdown -h now' is in the picture; after the
fourth "timing out command" message, I pressed the reset button.

Steve Berman
