Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3AFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280F320866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Jl42qJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbgCDXUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:20:12 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34851 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDXUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:20:11 -0500
Received: by mail-ot1-f53.google.com with SMTP id v10so3857667otp.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jy/pvy0/S47J0HPg+ESI5MKYVQkhuwYIBoiO31Jly64=;
        b=C3Jl42qJxkF0mvLmXgZAEVkWsYX+hYzBcbeXDJHqyhFhbfElcWW2jM8E7IsKljeOfF
         nwqLIsR+gxyWJ8TugC9KpbOLPLwI4DQMHgoaKGh5kmKkRoAXHSgW6iwxkQUL+be/zUOn
         HauQhcRHlfs8hcKO1OpF4NlnjcYnpIamEru59hXWdqcBhx6BKA2dHAaU8hpzBvH+w4Oh
         d5/rdyfJAsodY7wfaEH7oTTc41XlVlcrjFlyBxeKeZUcWLhbUuN8PY8satnpUawPW4j7
         9EZU8zWTbVszk2X35Knql56H9ivsPUVYsu6bnRTvAtwJUzK9N74W5e88xKBesLxXFKVD
         K/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy/pvy0/S47J0HPg+ESI5MKYVQkhuwYIBoiO31Jly64=;
        b=TzSJTADlpkQXc9+UwvtMbDw1/mApX/CnFP4ClIpjj0czKLFjdNOYo8W69RpPSDuVFU
         blUUE9DVN6aokNH/2ZC+0lUIPZLBusJAmp5iXAeJcmEdK0WDnXaoPCIu/FbEQEoUQd+6
         D32ajqq3GEgFCRPfPOfPV8MyvvXorjt1BFf81EI+W8sBqhCLnqZys4FANPzxzKzcpaju
         HIdNBIrDeJqth1K8FMMWnWfCEZ+3WOEw2JXY40ZV6ppoGUALmM8JaV7tqU/l3hMyRDl1
         7CZ8JI0mpHL6l8IndPf0H3pIZDwbi9VVHqgdAK8S0H6qvSyAJ0NcoEOsgiC6hBuIelMi
         jbxw==
X-Gm-Message-State: ANhLgQ2FFhOdLCQAdZx/NL17RpzncW7NEWj80CKng148Gb0yDcGbsMNq
        a8RyQtsDWt/7k8+LDXylRFk6aMRIFeRoGzKt8xA=
X-Google-Smtp-Source: ADFU+vszVvXygtAKW3mFBMvquBApv8Z8J0GuhCe3QjMiElyHEuV5ObCIGswswSfxwmzd7xZUh97S9G2dTHTxCTAPHgo=
X-Received: by 2002:a05:6830:1ca:: with SMTP id r10mr4159254ota.319.1583364010873;
 Wed, 04 Mar 2020 15:20:10 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
 <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
 <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
 <CAMArcTUJ=Nemq=hsEeOzc-hOU4bPOKq_Xa1ECGDk4ceZHzhGVw@mail.gmail.com>
 <CAM_iQpU+d4bbtN_oE+G0CaWmeSbBEyS1Wuc7s1vK36gGrcYzjQ@mail.gmail.com> <CACT4Y+Y-602aWheEZT8ha7qJ=P7uhu3LG5PqFebB7guNg8z=_w@mail.gmail.com>
In-Reply-To: <CACT4Y+Y-602aWheEZT8ha7qJ=P7uhu3LG5PqFebB7guNg8z=_w@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 4 Mar 2020 15:19:59 -0800
Message-ID: <CAM_iQpVkyt5C2RG==jJSHumpY1o+M2H0nHRtMs6xp6_fpW3WMA@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 12:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Jan 18, 2020 at 9:41 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Thu, Jan 16, 2020 at 7:09 AM Taehee Yoo <ap420073@gmail.com> wrote:
> > > Yes, I fully agree with this.
> > > If we calculate the subclass for lock_nested() very well, I think we
> > > might use static lockdep key for addr_list_lock_key too. I think
> > > "dev->upper_level" and "dev->lower_level" might be used as subclass.
> > > These values are updated recursively in master/nomaster operation.
> >
> > Great! I will think about this too. At least I will remove the other keys
> > for net-next.
>
> Hi Cong,
>
> Was this done? This still harms testing of the whole kernel. Disabling
> LOCKDEP does not look good either...

Not yet, I have a half-done patch locally, will work on it to make it
complete for net-next.

Thanks for reminding me!
