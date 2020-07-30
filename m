Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330D0206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohIiyLDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgG3H3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgG3H3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:29:01 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E40C0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 00:29:00 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id t187so5959749vke.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 00:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=at4PSvarONNx8uF/kP+5DqEXcjDZRY1qZ0MmYqMIcvc=;
        b=ohIiyLDPwOZD415DV/CkBJASHfDCAFARESlU4Ht6RlB1yXp2wjcF5ajMnVRhM/qpDA
         1sW8UBsjHg9JDdCLvBCsGbLLzqawnfJ47wHGLuS74VMLWtHykra2lhbC90z1ZiFs9xcB
         j5LfvBRkl/ey8bYEJPIPGyEHZg/dHzs62T+jDwFhqzBazxnReEEO22SLphkNLFHjIsua
         Ox+0vrjg0rNSoklSPCs1fgf5wL2osGqJHk6fw14qhK6/e2DuvuO00pmee2FOKJ5912pr
         XcdvuGjIff/0G4tsj0OFdHCRSwQHVsnMvFXfGSrAu+fLxEUY52nGyAwCVh/oQP6TF0ag
         Q+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=at4PSvarONNx8uF/kP+5DqEXcjDZRY1qZ0MmYqMIcvc=;
        b=X4WB7bqGaZ3Bfo1UlhL2Jio60wUSQPUcW7MGtgzxPWMNMSqm4WefO/pgS/ctJica5m
         ATT6flrotExXsqKujdBHV2zAO/t5RcWleYqldi4aIyLEG1Q2QAO88KG4k9DrmEeU7Riu
         +gLROTADBgEvw7drhYPwrr89pb5a28md76wi+T+t4nBmeZZQpD48EPqHlbdzTesaa/RX
         O21DUfPzjXK95oz56PgkMp4gNJ0LFQXFRn5f7ewLMlC6hBqLQKnObyH/w+WSWcgaKOzX
         XnnIL/7ZISEu1EZED0tfSRl0tar5W9ftTvZVfN7wnf9+7AiMzOhnW+48whLZaYx4cvAp
         ne9A==
X-Gm-Message-State: AOAM532WWJwUhLypnc98oUtpVtzMAKumuVDBCVrb7d1PR4Q6YlBr+gbH
        V4VX+U7k0bkiWG3tWpKm3nZKSQiI3tt+oqbQvDWZLBmUiq4=
X-Google-Smtp-Source: ABdhPJxmB23YSiQSrVg7/e8gsqnxK1aKwwwI9lUsVP4buoJsxCXlCyf65dRhEHdVBPrsrRt1oXk5iERlt42q4A/z0mA=
X-Received: by 2002:a1f:ae51:: with SMTP id x78mr899092vke.49.1596094139532;
 Thu, 30 Jul 2020 00:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200730022457.3021112-1-badhri@google.com> <20200730064356.GA3910237@kroah.com>
In-Reply-To: <20200730064356.GA3910237@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 30 Jul 2020 00:28:23 -0700
Message-ID: <CAPTae5LBfYni0m2+drcXfTtgbZZCzdEWb_r-XtkhhQ-8tP60EQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Yes Guenter's suspicion is right. Mine was conflicting with Han's
following patch:
commit 5f2b8d87bca528616e04344d1fc4032dc5ec0f3d
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Fri Jul 24 19:46:57 2020 +0200

    usb: typec: tcpm: Move mod_delayed_work(&port->vdm_state_machine)
call into tcpm_queue_vdm()

    All callers of tcpm_queue_vdm() immediately follow the tcpm_queue_vdm()
    vdm call with a:

            mod_delayed_work(port->wq, &port->vdm_state_machine, 0);

    Call, fold this into tcpm_queue_vdm() itself.

    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
    Signed-off-by: Hans de Goede <hdegoede@redhat.com>
    Link: https://lore.kernel.org/r/20200724174702.61754-1-hdegoede@redhat.=
com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Fixed merged conflicts and sent out the v4 version of the patch.
Added hdegoede@redhat.com to CC as well.

Thanks,
Badhri

On Wed, Jul 29, 2020 at 11:44 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 29, 2020 at 07:24:57PM -0700, Badhri Jagan Sridharan wrote:
> > "tReceiverResponse 15 ms Section 6.6.2
> > The receiver of a Message requiring a response Shall respond
> > within tReceiverResponse in order to ensure that the
> > sender=E2=80=99s SenderResponseTimer does not expire."
> >
> > When the cpu complex is busy running other lower priority
> > work items, TCPM's work queue sometimes does not get scheduled
> > on time to meet the above requirement from the spec.
> > Moving to kthread_work apis to run with real time priority.
> > Just lower than the default threaded irq priority,
> > MAX_USER_RT_PRIO/2 + 1. (Higher number implies lower priority).
> >
> > Further, as observed in 1ff688209e2e, moving to hrtimers to
> > overcome scheduling latency while scheduling the delayed work.
> >
> > TCPM has three work streams:
> > 1. tcpm_state_machine
> > 2. vdm_state_machine
> > 3. event_work
> >
> > tcpm_state_machine and vdm_state_machine both schedule work in
> > future i.e. delayed. Hence each of them have a corresponding
> > hrtimer, tcpm_state_machine_timer & vdm_state_machine_timer.
> >
> > When work is queued right away kthread_queue_work is used.
> > Else, the relevant timer is programmed and made to queue
> > the kthread_work upon timer expiry.
> >
> > kthread_create_worker only creates one kthread worker thread,
> > hence single threadedness of workqueue is retained.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> > Changes since v1:(Guenter's suggestions)
> > - Remove redundant call to hrtimer_cancel while calling
> >   hrtimer_start.
> >
> > Changes since v2:(Greg KH's suggestions)
> > - Rebase usb-next TOT.
> >   633198cd2945b7 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate workque=
ue to RT priority for processing events
> >   fa56dd9152ef95 (origin/usb-next) Merge tag 'usb-serial-5.9-rc1' of ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-nex=
t
> >   25252919a1050e xhci: dbgtty: Make some functions static
> >   b0e02550346e67 xhci: dbc: Make function xhci_dbc_ring_alloc() static
> >   ca6377900974c3 Revert "usb: dwc2: override PHY input signals with usb=
 role switch support"
> >   09df709cb5aeb2 Revert "usb: dwc2: don't use ID/Vbus detection if usb-=
role-switch on STM32MP15 SoCs"
> >   17a82716587e9d USB: iowarrior: fix up report size handling for some d=
evices
> >   e98ba8cc3f8a89 Merge tag 'usb-for-v5.9' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/balbi/usb into usb-next
> >   c97793089b11f7 Merge 5.8-rc7 into usb-next
> >   92ed301919932f (tag: v5.8-rc7, origin/usb-linus, origin/main) Linux 5=
.8-rc7
> >
>
> Hm, still does not apply.  I think it has something to do with other
> patches that landed before yours, can you rebase again?
>
> thanks,
>
> greg k-h
