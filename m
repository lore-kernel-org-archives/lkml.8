Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCE5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58354207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PDrkFN97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgFEE3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFEE3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:29:46 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12378C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 21:29:45 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r9so2854082ual.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yh4QPGB6BpMImnDSPQmPa4HQGaoN/XctUaVKXi5QYwY=;
        b=PDrkFN970k1ALTuEhfgcTlUwB71dPxvhGxU0C4VZu6nTHpZ+sXfAM6AMHZbir+bQX3
         7z5G2kw9yGZ+5zsqkvnXyaXOISL9lrVRVLvMfkr2sxLbV2+X63lVdLn9xYSDDlAj7Wgj
         FaiW9XEJ4Ha98qEQZAHR40fvGQ1NwOWOVeP6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yh4QPGB6BpMImnDSPQmPa4HQGaoN/XctUaVKXi5QYwY=;
        b=WHNKCqjsU7F3MCFzE4aayQDPCgTBv8t63c8IGpH41ueoT5FPVeEIcjA4axCVLjymNr
         cMpAAtcrBoXcxW1A/MhVGZEbsdXBSKG2DMKVZLty2pBmgf9YkdWM9pW5MvSDl7h/UdLx
         pfM041jP/n42TmIW5G4CnRJLwK2CBHpkTfKIk8ADPfa1KACl3CCCC6HTRbRXab/pZP3Q
         Cm1ajqBjGxXnVa63rVL2rOLiN3ngu0fsRcPMiUmp/3vz1rKkGyMrFTyKLuGbGb77UF8M
         HGV6n0bYxsIF5KzpcOjHnlsFgGSngnmXeMQn3Hgjc/MdXJTHgocGKL5/WUxvIKbL1FRl
         kl0Q==
X-Gm-Message-State: AOAM533b9W98XiXz4wW+QT+gN5mtzcKcm1qCLW4XkgJnv0022bju/KpS
        15bB/K88VT8OvdCvqpnQrN0FihhG/4aHnXiCpcq8Tg==
X-Google-Smtp-Source: ABdhPJxhlP+sLLzHaVKCIe6JgoxP8u6LPLZcqp5spma74BIukNjafi2Z1Xz/y+YXGyeAOVQ0H5gOM4Gf+h35CPbav1Q=
X-Received: by 2002:ab0:2bd4:: with SMTP id s20mr5781588uar.136.1591331384169;
 Thu, 04 Jun 2020 21:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200603132148.1.I0ec31d716619532fc007eac081e827a204ba03de@changeid>
 <CAJZ5v0i5VPk+HUb6P43Apb=MwanTkeWqjBMEemDo+fiBTM+eOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5VPk+HUb6P43Apb=MwanTkeWqjBMEemDo+fiBTM+eOg@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 4 Jun 2020 21:29:30 -0700
Message-ID: <CANFp7mWHX15oJAe_RgYbN+sHbPXmUYkYtvT9V0oszOc0Y=7TKg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Allow suspend even when preparation has failed
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sent a v2 with proper fixes and reported-by tags.

Thanks
Abhishek

On Thu, Jun 4, 2020 at 3:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jun 3, 2020 at 10:22 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > It is preferable to allow suspend even when Bluetooth has problems
> > preparing for sleep. When Bluetooth fails to finish preparing for
> > suspend, log the error and allow the suspend notifier to continue
> > instead.
> >
> > To also make it clearer why suspend failed, change bt_dev_dbg to
> > bt_dev_err when handling the suspend timeout.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Thanks for the patch, it looks reasonable to me.
>
> It would be good to add a Fixes tag to it to indicate that it works
> around an issue introduced by an earlier commit.
>
> Len, Todd, would it be possible to test this one on the affected machines?
>
> > ---
> > To verify this is properly working, I added an additional change to
> > hci_suspend_wait_event to always return -16. This validates that suspend
> > continues even when an error has occurred during the suspend
> > preparation.
> >
> > Example on Chromebook:
> > [   55.834524] PM: Syncing filesystems ... done.
> > [   55.841930] PM: Preparing system for sleep (s2idle)
> > [   55.940492] Bluetooth: hci_core.c:hci_suspend_notifier() hci0: Suspend notifier action (3) failed: -16
> > [   55.940497] Freezing user space processes ... (elapsed 0.001 seconds) done.
> > [   55.941692] OOM killer disabled.
> > [   55.941693] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
> > [   55.942632] PM: Suspending system (s2idle)
> >
> > I ran this through a suspend_stress_test in the following scenarios:
> > * Peer classic device connected: 50+ suspends
> > * No devices connected: 100 suspends
> > * With the above test case returning -EBUSY: 50 suspends
> >
> > I also ran this through our automated testing for suspend and wake on
> > BT from suspend continues to work.
> >
> >
> >  net/bluetooth/hci_core.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index dbe2d79f233fba..54da48441423e0 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3289,10 +3289,10 @@ static int hci_suspend_wait_event(struct hci_dev *hdev)
> >                                      WAKE_COND, SUSPEND_NOTIFIER_TIMEOUT);
> >
> >         if (ret == 0) {
> > -               bt_dev_dbg(hdev, "Timed out waiting for suspend");
> > +               bt_dev_err(hdev, "Timed out waiting for suspend events");
> >                 for (i = 0; i < __SUSPEND_NUM_TASKS; ++i) {
> >                         if (test_bit(i, hdev->suspend_tasks))
> > -                               bt_dev_dbg(hdev, "Bit %d is set", i);
> > +                               bt_dev_err(hdev, "Suspend timeout bit: %d", i);
> >                         clear_bit(i, hdev->suspend_tasks);
> >                 }
> >
> > @@ -3360,12 +3360,15 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
> >                 ret = hci_change_suspend_state(hdev, BT_RUNNING);
> >         }
> >
> > -       /* If suspend failed, restore it to running */
> > -       if (ret && action == PM_SUSPEND_PREPARE)
> > -               hci_change_suspend_state(hdev, BT_RUNNING);
> > -
> >  done:
> > -       return ret ? notifier_from_errno(-EBUSY) : NOTIFY_STOP;
> > +       /* We always allow suspend even if suspend preparation failed and
> > +        * attempt to recover in resume.
> > +        */
> > +       if (ret)
> > +               bt_dev_err(hdev, "Suspend notifier action (%x) failed: %d",
> > +                          action, ret);
> > +
> > +       return NOTIFY_STOP;
> >  }
> >
> >  /* Alloc HCI device */
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
> >
