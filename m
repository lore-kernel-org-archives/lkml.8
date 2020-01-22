Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C370C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C5B2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBSBvk3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgAVRxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:53:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38314 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgAVRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:53:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so7859584ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mW0UHoFIxjOyIh8QCXlQsNoXtKdA7iyG/V+neN/Occ=;
        b=kBSBvk3qeXcKp9zR6XWAz9wjq8nY4fZwhVfMN5KoZiARy6tYV0Mw9rW0T6W9OAQeht
         Bac1Z5bEYZOwRFEt1j0+jPWqL3MEvUmXZpHfyVm3F0hSMVkqM3EGdFjagqyLXQNU7P3Q
         XLXWqIfmE0AT5tO9G8nal/7afupBDCILcEgDVwcj2GtY8rZrXWAtv+2avEJOSjkreUCQ
         J2XeBx35GiByPkwK52w2NZAs2fD+R7sibn0LzC0MxutyB9ilujbGmgEmMckCEXQyoRuR
         uZDPJ5md4uhzS/fKAhtZhAQC4O/YWxiJpdj0h773HsN94ejxgyGCL8wVXaPg6JeInp2T
         SdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mW0UHoFIxjOyIh8QCXlQsNoXtKdA7iyG/V+neN/Occ=;
        b=sN9maBptH8qMM8criudrkriKYwdX7wae8xGVvf4i22HRhXsw5MWbHGZGV5gP8rruyv
         lS3dsMvETi6Hg3nLFTC5GcoTPw1Vi7piPZ7qMErmGmngln7YIqQpwqRj9bqmQSmBdqD9
         nMv+u2Xu1JBolQiQqBldCaPS0IViyM5EmVQyCIggGF6CZUiy5wTBf/U74BwtHP24pPg0
         ZG1vU0uNK0Ip5DfA9ifVEyWpXCs1oJt6bdfWK3o3yv/Ourppeap3/APqYMd56pHIV7Yv
         o+KEksHJURIPrkMKyhVt/wwx8SY1bXjR/Aih03nfRipixxt6xf9xUxjybEZX/chpGsZP
         4RQA==
X-Gm-Message-State: APjAAAWucTMxS7C9Yo2C8nHQw8xoxzl/0K0ftS3KbKmfDyoEgORvV59R
        pBrvuu3A8GcsobNH0pVZnvuaCoKCPOVrf4iyZJVArg==
X-Google-Smtp-Source: APXvYqwFMDdNIrZSBXSOOXdm3BH047M17zfpniLRXLHGHQZgVKLwsa0rVLhl910ek/eCeIlyy1sLan1cLMRF9l2NL+Q=
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr20717832ljh.28.1579715586165;
 Wed, 22 Jan 2020 09:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20200106181425.Bluez.v1.1.I5ee1ea8e19d41c5bdffb4211aeb9cd9efa5e0a4a@changeid>
 <CD07E771-6F40-4158-A0F9-03FC128CDCD3@holtmann.org>
In-Reply-To: <CD07E771-6F40-4158-A0F9-03FC128CDCD3@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 22 Jan 2020 12:52:54 -0500
Message-ID: <CALWDO_VUckYfEbh8RC=X2zqWKd5+2qOEux2ctdpo_Jfwkt_V9g@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] bluetooth: secure bluetooth stack from bluedump attack
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Yun-hao Chung <howardchung@google.com>,
        BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan, Luiz,

Did you have additional feedback on this before we can send a new
version to address Marcel's comments?

Marcel, you are right, LE likely will need a similar fix.  Given we
currently have SC disabled on chromium, we can probably submit this as
a separate patch unless someone else would like to contribute it
sooner.

Thanks,
Alain

On Wed, Jan 8, 2020 at 4:02 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Howard,
>
> > Attack scenario:
> > 1. A Chromebook (let's call this device A) is paired to a legitimate
> >   Bluetooth classic device (e.g. a speaker) (let's call this device
> >   B).
> > 2. A malicious device (let's call this device C) pretends to be the
> >   Bluetooth speaker by using the same BT address.
> > 3. If device A is not currently connected to device B, device A will
> >   be ready to accept connection from device B in the background
> >   (technically, doing Page Scan).
> > 4. Therefore, device C can initiate connection to device A
> >   (because device A is doing Page Scan) and device A will accept the
> >   connection because device A trusts device C's address which is the
> >   same as device B's address.
> > 5. Device C won't be able to communicate at any high level Bluetooth
> >   profile with device A because device A enforces that device C is
> >   encrypted with their common Link Key, which device C doesn't have.
> >   But device C can initiate pairing with device A with just-works
> >   model without requiring user interaction (there is only pairing
> >   notification). After pairing, device A now trusts device C with a
> >   new different link key, common between device A and C.
> > 6. From now on, device A trusts device C, so device C can at anytime
> >   connect to device A to do any kind of high-level hijacking, e.g.
> >   speaker hijack or mouse/keyboard hijack.
> >
> > To fix this, reject the pairing if all the conditions below are met.
> > - the pairing is initialized by peer
> > - the authorization method is just-work
> > - host already had the link key to the peer
> >
> > Also create a debugfs option to permit the pairing even the
> > conditions above are met.
> >
> > Signed-off-by: howardchung <howardchung@google.com>
>
> we prefer full name signed-off-by signatures.
>
> > ---
> >
> > include/net/bluetooth/hci.h |  1 +
> > net/bluetooth/hci_core.c    | 47 +++++++++++++++++++++++++++++++++++++
> > net/bluetooth/hci_event.c   | 12 ++++++++++
> > 3 files changed, 60 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 07b6ecedc6ce..4918b79baa41 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -283,6 +283,7 @@ enum {
> >       HCI_FORCE_STATIC_ADDR,
> >       HCI_LL_RPA_RESOLUTION,
> >       HCI_CMD_PENDING,
> > +     HCI_PERMIT_JUST_WORK_REPAIR,
> >
> >       __HCI_NUM_FLAGS,
> > };
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 9e19d5a3aac8..9014aa567e7b 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -172,10 +172,57 @@ static const struct file_operations vendor_diag_fops = {
> >       .llseek         = default_llseek,
> > };
> >
> > +static ssize_t permit_just_work_repair_read(struct file *file,
> > +                                         char __user *user_buf,
> > +                                         size_t count, loff_t *ppos)
> > +{
> > +     struct hci_dev *hdev = file->private_data;
> > +     char buf[3];
> > +
> > +     buf[0] = hci_dev_test_flag(hdev, HCI_PERMIT_JUST_WORK_REPAIR) ? 'Y'
> > +                                                                   : 'N';
> > +     buf[1] = '\n';
> > +     buf[2] = '\0';
> > +     return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> > +}
> > +
> > +static ssize_t permit_just_work_repair_write(struct file *file,
> > +                                          const char __user *user_buf,
> > +                                          size_t count, loff_t *ppos)
> > +{
> > +     struct hci_dev *hdev = file->private_data;
> > +     char buf[32];
> > +     size_t buf_size = min(count, (sizeof(buf) - 1));
> > +     bool enable;
> > +
> > +     if (copy_from_user(buf, user_buf, buf_size))
> > +             return -EFAULT;
> > +
> > +     buf[buf_size] = '\0';
> > +     if (strtobool(buf, &enable))
> > +             return -EINVAL;
> > +
> > +     if (enable)
> > +             hci_dev_set_flag(hdev, HCI_PERMIT_JUST_WORK_REPAIR);
> > +     else
> > +             hci_dev_clear_flag(hdev, HCI_PERMIT_JUST_WORK_REPAIR);
> > +
> > +     return count;
> > +}
> > +
> > +static const struct file_operations permit_just_work_repair_fops = {
> > +     .open           = simple_open,
> > +     .read           = permit_just_work_repair_read,
> > +     .write          = permit_just_work_repair_write,
> > +     .llseek         = default_llseek,
> > +};
> > +
> > static void hci_debugfs_create_basic(struct hci_dev *hdev)
> > {
> >       debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
> >                           &dut_mode_fops);
> > +     debugfs_create_file("permit_just_work_repair", 0644, hdev->debugfs,
> > +                         hdev, &permit_just_work_repair_fops);
> >
> >       if (hdev->set_diag)
> >               debugfs_create_file("vendor_diag", 0644, hdev->debugfs, hdev,
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 6ddc4a74a5e4..898e347e19e0 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4539,6 +4539,18 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
> >               goto unlock;
> >       }
> >
> > +     /* If there already exists link key in local host, terminate the
> > +      * connection by default since the remote device could be malicious.
> > +      * Permit the connection if permit_just_work_repair is enabled.
> > +      */
> > +     if (!hci_dev_test_flag(hdev, HCI_PERMIT_JUST_WORK_REPAIR) &&
> > +         hci_find_link_key(hdev, &ev->bdaddr)) {
> > +             BT_DBG("Rejecting request: local host already have link key");
>
> Can we use bt_dev_warn() here.
>
> > +             hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_NEG_REPLY,
> > +                          sizeof(ev->bdaddr), &ev->bdaddr);
> > +             goto unlock;
> > +     }
> > +
> >       /* If no side requires MITM protection; auto-accept */
> >       if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
> >           (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
>
> What about the LE cases?
>
> In addition, I like to get a pair of second eyes from Johan and Luiz on this one.
>
> Regards
>
> Marcel
>
> --
> You received this message because you are subscribed to the Google Groups "ChromeOS Bluetooth Upstreaming" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> To post to this group, send email to chromeos-bluetooth-upstreaming@chromium.org.
> To view this discussion on the web visit https://groups.google.com/a/chromium.org/d/msgid/chromeos-bluetooth-upstreaming/CD07E771-6F40-4158-A0F9-03FC128CDCD3%40holtmann.org.
