Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 09:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EDE2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 09:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePgC16u/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgHWJ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgHWJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 05:26:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E4BC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 02:26:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x6so2518092qvr.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1sYF8go7qkIJfXgsFM0jG5g2kLGG3UutjF1ASPDx3Y=;
        b=ePgC16u/C5fV3JjKJ4mqDBjBKX7rE8F5HKEV6aigJmB/MT0dpC6RU3uQWbhAfk9tUp
         RCR7HIz1aGfyaWYfV3GYIthDlOREgyLhCneg+gG//QsMKzs3fAzx+vysXc9j4vsXQOrt
         AbkVzaoQHcRTZHsieukpuWTyIr5I+Xd15gqNmwG/AqciZW/DLPSxu8sSVPnLDWlGBHHD
         VHAWW5VLQGH6HQ20FmLfJcODHQuHT1SSbllPBfD8cKutqH3Lki5oRx19oMGJpXVIH12A
         xq/5H9ylhHxH+F5YsJtY5387XcOHxSohttYGk7ZRlN2dwZiilN/axFky6oj1IQUmV2VI
         Nyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1sYF8go7qkIJfXgsFM0jG5g2kLGG3UutjF1ASPDx3Y=;
        b=AUqRLOLAD8LbSi6L7laQl1dBMagnTCoakAp09lCXBvcuS3fKcJYANutxuIxbHllYjI
         ktO4bNhRRpRYEjurQXC7CxyYjgw6zJxr98ZZ9WyibuuxGcBBEPzTT6jV5ltX6wGcvH/l
         MivBgcIIX+vzdSl7D2BzV6W5sNmMQ7quCHQuLCKJmgxfETRqe3wrI6TeoDUnG6jxAVK5
         cApM2ksnXcLQAGG89XkzeG8auV9snPN7sL+z3EdDKrG2AuJAhqP9FVeqbl1Y2lHw6NGd
         vRw6TxPmKnc2tikGQ+NzzPmnZKBSzm7PRbT8+PvSRDdlNOxxikigBYZ1TqBNiOqfClyU
         HZNA==
X-Gm-Message-State: AOAM533TQxY+NN5/xeamy40kaz5AQFz1SbdrqZciYIMGeMJq4dzrsthH
        n3iIQrOfRcOAWOUdNrpjHyfoLgL7KFrfYNzNOMmnlg==
X-Google-Smtp-Source: ABdhPJyRzSGIRnG9KdFdUSjw7nF3cpcCtQH1Pk0Y2ZVnelPepWNaPSLGOZB1ugjQ9FrlSgcpZPWH4jpnNU6VoPO2oTw=
X-Received: by 2002:a0c:cc94:: with SMTP id f20mr472014qvl.159.1598174798398;
 Sun, 23 Aug 2020 02:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200823082042.20816-1-himadrispandya@gmail.com>
In-Reply-To: <20200823082042.20816-1-himadrispandya@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 23 Aug 2020 11:26:27 +0200
Message-ID: <CACT4Y+Y1TpqYowNXj+OTcQwH-7T4n6PtPPa4gDWkV-np5KhKAQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: Fix uninit-was-stored issue in asix_read_cmd()
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 10:21 AM Himadri Pandya
<himadrispandya@gmail.com> wrote:
>
> Initialize the buffer before passing it to usb_read_cmd() function(s) to
> fix the uninit-was-stored issue in asix_read_cmd().
>
> Fixes: KMSAN: kernel-infoleak in raw_ioctl
> Reported by: syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com
>
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/net/usb/asix_common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> index e39f41efda3e..a67ea1971b78 100644
> --- a/drivers/net/usb/asix_common.c
> +++ b/drivers/net/usb/asix_common.c
> @@ -17,6 +17,8 @@ int asix_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>
>         BUG_ON(!dev);
>
> +       memset(data, 0, size);

Hi Himadri,

I think the proper fix is to check
usbnet_read_cmd/usbnet_read_cmd_nopm return value instead.
Memsetting data helps to fix the warning at hand, but the device did
not send these 0's and we use them as if the device did send them.

Perhaps we need a separate helper function (of a bool flag) that will
fail on incomplete reads. Maybe even in the common USB layer because I
think we've seen this type of bug lots of times and I guess there are
dozens more.


>         if (!in_pm)
>                 fn = usbnet_read_cmd;
>         else
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200823082042.20816-1-himadrispandya%40gmail.com.
