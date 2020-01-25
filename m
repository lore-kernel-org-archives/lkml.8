Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A86C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3B32072C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knntdm2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgAYB1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:27:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46880 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgAYB1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:27:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so4260201wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 17:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0UCdtd5wOKdRZl19WtlX7C/3OJnEBeAa3u4401/i9UY=;
        b=knntdm2xU2O3mwFLzNREvWmtTcVAqdZBleeKIevo6sb2BmwH1fkitF2kGx6pM5sS09
         eaTvS2wr8uNsyIJHiowTmDIKkeMG0xCJMH5UamWroahuC56mVb6GLj38TaN/cu+na6PB
         ZrDPiwE9stbDI3TMnuATu49LW/zClWFpPbsNd19YKTkRi8xHn4+SnwTVMKjjteBAJvtP
         Ir3Gh5/uCr3nPfaSs8Hv2QJwuosBqNxzIQlsRBj+ZcGZ/twPuq6x5MTgQeXGQhIDDBo2
         CFixJE70RTiaPPCw/YfA0MHlEuSW5J5i4coiwXz0YSbmE81OifcQG6FQoikFiQHY4Q7B
         UImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0UCdtd5wOKdRZl19WtlX7C/3OJnEBeAa3u4401/i9UY=;
        b=igtAZoVPy1mEglFX4JD4LOYSBXcfGTa4eZdiNQNnGG4Gla6iN6yD3KZLGjHjOpVS2A
         fjaCzYXff3u+36pPKsh5fY9cgEgScQd185kq3HhUrOpJV3PAb27Z9G8oQBAHExmoEH2S
         F4x/aMF0MJS4ZWEWH2ET78tLv1B030zuXvlpyigZSq8OMyDAiXIMDyjrvS6XsicPWXcy
         IJIKz8IlormZaMBEnI3CvYDAomSL4ShCEB4/EXy84fKFZtKnT8laYF5LIZh2SuXi1ADU
         4wf2FIH48M2eOUSBsV9tBuZcKXG8E4/z8rea0KYj8B+IGC8/IsKVbzbUx9kGSrxq6KUa
         3rhg==
X-Gm-Message-State: APjAAAUAV1XIQwSIOnGgn0zfXk+pggWy8KCiFxioPdVEk2DJN1tEXYtQ
        dU1sngq/vO5ygps5oO2yUg==
X-Google-Smtp-Source: APXvYqxfdLmXVGaWTb5Hbrc9hEuoZEqWPZ4wvZv4FeFUEhViyjDufOE+9kimn9bQ0CJLJsqeGuZQFQ==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr7025104wrs.376.1579915636703;
        Fri, 24 Jan 2020 17:27:16 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-87.as43234.net. [92.15.174.87])
        by smtp.gmail.com with ESMTPSA id a62sm4496wmh.33.2020.01.24.17.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:27:15 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Sat, 25 Jan 2020 01:26:58 +0000 (GMT)
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] time: Add missing annotation to
 lock_hrtimer_base()
In-Reply-To: <87d0b8mry4.fsf@nanos.tec.linutronix.de>
Message-ID: <alpine.LFD.2.21.2001250115550.8426@ninjahub.org>
References: <cover.1579893447.git.jbi.octave@gmail.com> <31c31ca2d78d9368d38e1a5909bc0c9a7be5dc98.1579893447.git.jbi.octave@gmail.com> <87d0b8mry4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Thomas. I really appreciate your feedback, I take good note and I 
will send a different version with all the changes in reference to the 
email. 
 
Thanks again,
Kind regards
Jules

On Fri, 24 Jan 2020, Thomas Gleixner wrote:

> Jules,
> 
> Jules Irenge <jbi.octave@gmail.com> writes:
> 
> Please use the proper subsystem prefixes when sending patches.
> 
> git log --oneline path/to/file
> 
> gives you usally a pretty good hint.
> 
> > Sparse reports a warning at lock_hrtimer_base()
> >
> > |warning: context imbalance in lock_hrtimer_base() - wrong count at exit
> 
> This leading '|' is pointless
> 
> > |warning: context imbalance in hrtimer_start_range_ns() - unexpected unlock
> > |warning: context imbalance in hrtimer_try_to_cancel() - unexpected unlock
> > |warning: context imbalance in __hrtimer_get_remaining()
> > |- unexpected unlock
> 
> How are the last 3 related to:
> 
> > Sparse reports a warning at lock_hrtimer_base()
> 
> ?
> 
> > To fix this , an __acquires(timer) annotation is added.
> 
>   Add the missing __acquires(timer) annotation.
> 
> Is precise and follows the recommendations of Documentation/process/...
> 
> > Given that lock_hrtimer_base() does actually call READ_ONCE(timer->base).
> 
> Given that the above sentence uses 'Given that' it should not terminate
> right after explaining the 'Given'.
> 
> > This not only fixes the warnings but also improves on readability of
> > the code.
> 
> I tend to disagree. In fact the annotation disturbes the reading flow
> because it's on a separate line.
> 
> Can you please stop using this boilerplate which is neither helping
> review nor giving someone who looks at the commit later on any useful
> information?
> 
> Here is a suggestion for a change log for this:
> 
>   Sparse reports several warnings;
>    warning: context imbalance in lock_hrtimer_base() - wrong count at exit
>    warning: context imbalance in hrtimer_start_range_ns() - unexpected unlock
>    warning: context imbalance in hrtimer_try_to_cancel() - unexpected unlock
>    warning: context imbalance in __hrtimer_get_remaining()- unexpected unlock
> 
>   The root cause is a missing annotation of lock_hrtimer_base() which
>   causes also the 'unexpected unlock' warnings.
>   
>   Add the missing __acquires(timer) annotation.
> 
> Hmm?
> 
> The other 2 patches of this series have similar issues. The futex
> changelog is also horribly formatted.
> 
> Thanks,
> 
>         tglx
> 
