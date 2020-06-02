Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAE8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399F7206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlVJzfDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgFBM1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgFBM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:27:12 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A132C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:27:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b6so12376895ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzkhBbLbmHxP92irZBt7jTabNaEj2bzN89Fv4cbtbow=;
        b=RlVJzfDPTeQf0cs8V529R1SL0IM9WLu1oq53oOBFnQc8CK7laDj1EXvNHcyNU7V3zL
         +hXDt9b/b0xTrPHdqxXc5mLcM7EJ5dVO2I6Ug3oXT2mUdocCSC7VVaPksud5NiZ/Ilau
         NcI7/WOUlhrUOn8q+a1lZth0gnGnO6+uO9LCCqPMKUVPhG1j0feT4IjzQFd61Mz7JMqd
         nF71TdjlYJsmbzlQ4edArYM9MhueZrxOvwjZSJixgZAfpUBPhI8cbipg3duiOWySK80w
         FkASaPRR625pL/WUC6R1Kj6Aos86ohAjKZvRtqfOwppDQLRNljFWYBEx0ESYjA4CC/44
         Tuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzkhBbLbmHxP92irZBt7jTabNaEj2bzN89Fv4cbtbow=;
        b=SgGxriIOxlXwVDmwMAr3KGZQ9GVu8yDhpILiC9JcR5kdxVnLX2Yv7QFibafkR/+FVw
         0AI/7QoRqbrxQ3Ug7PR6XYuJTjvio33NNTTrS1WMPzl1V5iEcre73L9ReYtKREbKmKCk
         AGFLuB827anOY61tFeR81xUIy+kj0zu/+RSaLIG0YvuI6sJ58YhhmMMsZHwGzfu8jjPC
         O9yOLQiFO+OEXcgMBDSAIq1ZnkM2Kci//Us9oDCQqCAEbU83J0m4jYGUEXhRiJrApmfq
         tJpVtVhcx06lJctubWOqvEw0xpKl4TnugO3LrjMgsIrGPKg6mUFIDKD+d2seaPX/T8ez
         FcHQ==
X-Gm-Message-State: AOAM531/SLjgaAME9awK0NGeFIADFwvb3fr9S5jna17N8GIMYgtcZRdP
        /AKoJgAIky3QiHEd1h/y3JbpyhwPdIVQH95LFdar6w==
X-Google-Smtp-Source: ABdhPJz5gVZkHpLqefodvt73dt1ctZHG9Ln62jnSZBf/xAjF6zl95qgtHq8WB33aWNsSv7HXwC+Z52otFsPcw/1BNnw=
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr7949105ljj.3.1591100830499;
 Tue, 02 Jun 2020 05:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200601184223.1.I281c81384150e8fefbebf32fa79cb091d0311208@changeid>
 <CANFp7mXDvdicvyEpU-oDu4fBj92nQ7SENVdd_rG9TFQkqDevZg@mail.gmail.com>
In-Reply-To: <CANFp7mXDvdicvyEpU-oDu4fBj92nQ7SENVdd_rG9TFQkqDevZg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 2 Jun 2020 08:26:59 -0400
Message-ID: <CALWDO_VetmqNFf1TT0zk2ijURy004hsipGwgtX6arS-TKqFbpw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Check scan state before disabling during suspend
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Manish Mandlik <mmandlik@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 9:49 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hey linux-bluetooth,
>
> We found this bug when reverting some Chromium maintained patches in
> our repository that was conditionally dropping LE scan enable commands
> if it wasn't toggling between true/false. On some Intel controllers,
> disabling LE scan when it's already disabled resulted in a "Command
> Disallowed" and this was causing suspend to fail.
>
> On Mon, Jun 1, 2020 at 6:43 PM Manish Mandlik <mmandlik@google.com> wrote:
> >
> > Check current scan state by checking HCI_LE_SCAN flag and send scan
> > disable command only if scan is already enabled.
> >
> > Signed-off-by: Manish Mandlik <mmandlik@google.com>
> > ---
> >
> >  net/bluetooth/hci_request.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 1fc55685da62d..1acf5b8e0910c 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -998,8 +998,9 @@ static void hci_req_set_event_filter(struct hci_request *req)
> >
> >  static void hci_req_config_le_suspend_scan(struct hci_request *req)
> >  {
> > -       /* Can't change params without disabling first */
> > -       hci_req_add_le_scan_disable(req);
> > +       /* Before changing params disable scan if enabled */
> > +       if (hci_dev_test_flag(req->hdev, HCI_LE_SCAN))
> > +               hci_req_add_le_scan_disable(req);
> >
> >         /* Configure params and enable scanning */
> >         hci_req_add_le_passive_scan(req);
> > @@ -1065,8 +1066,9 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
> >                 page_scan = SCAN_DISABLED;
> >                 hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
> >
> > -               /* Disable LE passive scan */
> > -               hci_req_add_le_scan_disable(&req);
> > +               /* Disable LE passive scan if enabled */
> > +               if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
> > +                       hci_req_add_le_scan_disable(&req);
> >
> >                 /* Mark task needing completion */
> >                 set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
> >
>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
>
> --
> You received this message because you are subscribed to the Google Groups "ChromeOS Bluetooth Upstreaming" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> To post to this group, send email to chromeos-bluetooth-upstreaming@chromium.org.
> To view this discussion on the web visit https://groups.google.com/a/chromium.org/d/msgid/chromeos-bluetooth-upstreaming/CANFp7mXDvdicvyEpU-oDu4fBj92nQ7SENVdd_rG9TFQkqDevZg%40mail.gmail.com.
