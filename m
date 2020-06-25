Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B3FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256BA207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gEFD/h6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406605AbgFYXS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406523AbgFYXSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:18:54 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA054C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:18:54 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k7so3172965vso.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZUejZ4FxIPzgalcSBOTl7RrSB8oG1JXXKFu2TzIVTY=;
        b=gEFD/h6/YccJ6NUPfYT/xgz0X+isX8Cd6CGn2UCUGx7jpM3t81GIEKLZxSIh9n3gSf
         LyFFAVqzLW2EOg2vox4IxQFv/KkghELE3h+1pMYcAk3L5vCjE1vuqYv6ModKBhiykPJm
         E+uZ3A7Yo3f2524NLn2qvAOct1Q0SfZjBL3KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZUejZ4FxIPzgalcSBOTl7RrSB8oG1JXXKFu2TzIVTY=;
        b=PaTczHXuhYnWPVHAmMIQE8/f1DLOIAN/w3Fery0pSlHTb+cAm45TgeRNZTTE+DLGQR
         BCwhEHxoMf3yjTLkaiVhHESpNU+tkF9JPzPDkyTQjTBEo3bJjRtFqUfS0zYVqGqr9KhL
         M73rpnzEnQpMi6TakQmBp6VVVNYzOivOoPS1d5jmQWMNdGh1uHHhYjK+UqNmW9Cc0Q4N
         vCanxX4LDerBnNkn5TY9RcH6axYTWHrY0oH2HhTV5pPJkmEOx5iNmGTEDL6Gx3K2Ic8U
         eLi72M66ytRVDLXPHMyP8rH7vKvPMM3bMlnUnNptTPjHiozifyPpjwYkWUtVdVLFXphY
         pyRQ==
X-Gm-Message-State: AOAM532IG6m7WMRGD0ijnWli6AYpoGbHqhC+Gj+q9VBZ3cMU+/MxifrZ
        lXvQT5Y8jFcyeuetuCKrlh30T9sglcjEa2WdyVt9V1FM
X-Google-Smtp-Source: ABdhPJzhi8dHdwc7k/3b1+iOeFD6RskzYY/+B8+g9RbXB08kX6vZ9AZiixX+D9Pnv0ODrkx1cdSZ8uCd7wY1U33lSFI=
X-Received: by 2002:a05:6102:1167:: with SMTP id k7mr517235vsg.71.1593127133874;
 Thu, 25 Jun 2020 16:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200624111128.v2.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
 <1593080522.28236.17.camel@suse.com>
In-Reply-To: <1593080522.28236.17.camel@suse.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 25 Jun 2020 16:18:42 -0700
Message-ID: <CANFp7mUmk=HqPyJ5TS5uQPyaEtOWdz=D+7XBS8MyikuF9y9EJQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Reset port on cmd timeout
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-usb@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the heads up Oliver -- I will send a patch with a comment on this.

On Thu, Jun 25, 2020 at 3:22 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Mittwoch, den 24.06.2020, 11:11 -0700 schrieb Abhishek Pandit-
> Subedi:
> > QCA_ROME sometimes gets into a state where it is unresponsive to
> > commands. Since it doesn't have support for a reset gpio, reset the usb
> > port when this occurs instead.
>
> Hi,
>
> on first glance this looks like an unbalanced PM reference. It is not
> because the operation is suicidal, but this deserves a comment, unless
> you want to get a note telling you that you caused an imbalance every
> few weeks.
>
>         Regards
>                 Oliver
>
