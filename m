Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F4EC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A5520724
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6BxXPSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgCUR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:26:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCUR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 13:26:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so3895151plr.11;
        Sat, 21 Mar 2020 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wh+F5SIyKnqSR8r3BIW8m3yDVbB2dv6d+r55H9JcfeY=;
        b=B6BxXPSleWUoByMhGFBHuFbyh0EkSMYwT8Mvf9cudRwZr+E7X8VXPZv2XfIKJmLQeY
         BhIn27vlY30dy/hQn6/vWcthcixNmlBEx0+ur/erlCUDhq0eJrGNmT9aVRSVzE0Xn498
         Q8B+uhW3TdBf2zFVbge+hTd0Hj6pyt97DKJWyaZwA7696yUgzM4EWvrQEVGDyd352hzz
         NPQiFOYq2QHjYLTs4cWc2MmTGoS9nfzje56NTyz6NMdiqHZuUR3ZzakTeF/1MhvjmQ6L
         bVEp4Ft9sRdLByDHzI66I/Y3ZwUZ1zll52BdA6fwN87vkHMxjoxXU+5mNC+ILS4jR65P
         VE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wh+F5SIyKnqSR8r3BIW8m3yDVbB2dv6d+r55H9JcfeY=;
        b=ZUjX6LtDhCwtq5AFvx7qYzMA1uhnJfl7Y5zuKd60BkJgpwroVm1aSj55KHhvlKZNia
         aaIYIyDAsgDgZgdYqe0+CAnEyDPlM7DnhgvA+bDU9ji91Cm9M2HWrn0/gZ4wLtzcLx5D
         MFQDHimIY9iUFuEiTNh51P7sdtTUs4bUJB+PV2cy+4V3MlvbTeZ4deT4qeNRduD5EQ1E
         n7n0QBUqx47s3L8lpIH0iDzVP103XQTAHNu+ds1Mb+q0oYIq4uRnVFcN96m90wbEpwMd
         fgUMJqehYUsVSJWEMClKsJhcprSy3eYousr6fgSCVZwb4u9FvX+yqEh5F6vHYBdO4yjx
         8kcg==
X-Gm-Message-State: ANhLgQ0DZlUTxHs+DccQ0OzEmC1LMQcETRiqt9NYfrZULLExZ2maCCWy
        g/D/nx7BwjWO7/qja0d4iwLtmzrZ
X-Google-Smtp-Source: ADFU+vsBdOq60T50L/6kP0lctVVpQ5Cm+zzONNsxk/Bi4edjZoedu8Z+XzVv2werpqD+5lbaTvzQMw==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr13881899plt.149.1584811588887;
        Sat, 21 Mar 2020 10:26:28 -0700 (PDT)
Received: from localhost ([49.207.51.24])
        by smtp.gmail.com with ESMTPSA id b19sm7747200pju.12.2020.03.21.10.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Mar 2020 10:26:28 -0700 (PDT)
Date:   Sat, 21 Mar 2020 22:56:26 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/cleanups] x86: Replace setup_irq() by request_irq()
Message-ID: <20200321172626.GA6323@afzalpc>
References: <158480051619.28353.14186528712410718742.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158480051619.28353.14186528712410718742.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 02:21:56PM -0000, tip-bot2 for afzal mohammed wrote:

> The following commit has been merged into the x86/cleanups branch of tip:

> [ tglx: Use a local variable and get rid of the line break. Tweak the
>   	comment a bit ]
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/17f85021f6877650a5b09e0212d88323e6a30fd0.1582471508.git.afzal.mohd.ma@gmail.com

Oh Thomas, you picked up v2, i had sent v3 [2], wherein i had taken
care of your comments on v1 [1] as well as with more commit message
tweaking (v2 was sent before you commented on v1)

You have mentioned about merging the series here [3], i have been
keeping in mind that and proceeding, but is delayed due to the reason
mentioned below.

i was planning to send this as well as the patches that are not taken
care by respective maintainers along with the core removal patch as a
series. The reason to delay is the concern over ARM & powerpc patches -
wanted to let the patches for those 2 arch's go in thr' respective
maintainers in their natural flow rather than keep pinging them.

powerpc - in patchworks it is shown as under review after passing all
the tests, so expecting it to go in soon.

ARM - i am expecting these to be picked up by Arnd/Olof shortly as
they are yet to pickup any of the pull requests for ARM, you have been
copied in the followup mail [4].

As of now only c6x, hexagon, sh, unicore32 & alpha are the ones that i
have to send you. All others have been picked up by respective
maintainers & are in next.

Regards
afzal

[1] https://lkml.kernel.org/r/87v9nsmhjj.fsf@nanos.tec.linutronix.de
[2] https://lkml.kernel.org/r/20200229125510.2897-1-afzal.mohd.ma@gmail.com
[3] https://lkml.kernel.org/r/87y2somido.fsf@nanos.tec.linutronix.de
[4] https://lkml.kernel.org/r/20200317043702.GA5852@afzalpc
