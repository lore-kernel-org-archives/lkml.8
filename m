Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31277C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0674424654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adVpB5W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBTJJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:09:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbgBTJJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582189765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KN7rEECvZEXdU6a12wfZOhPFPAnfs6WWVcWaa4l8tB8=;
        b=adVpB5W/QC4e9+Sl4UWvZ/clgPeUBo6qrwVgHPekqzxwS7Kkf94B0c5JIHyIHx+zxvhpvy
        pbJSeVkP6C2yqslQwulDYHT8Ubl+Pi29mo1T6OvTIQtP3bMLbUSMCayxvdrfdp8/W4bHds
        ytmqwMVCyrdiEdJQ3SKzaTzIRWC1yjU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-3MY_vCxRO36enoZna6uP-A-1; Thu, 20 Feb 2020 04:09:23 -0500
X-MC-Unique: 3MY_vCxRO36enoZna6uP-A-1
Received: by mail-wm1-f72.google.com with SMTP id p2so548197wmi.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KN7rEECvZEXdU6a12wfZOhPFPAnfs6WWVcWaa4l8tB8=;
        b=Y3+iBf5SdVZyYRP6V8JsfWRvtMn5A8dpZuWpX0HU8dIweKp6nKoGiwOFvW/7Y/VJc+
         egN4egcGcyIXNas5f1bSbnIvTkEwRM7g9eF0O79l3l0iB7FHtYpWp1XUtKUPRGdFmv/a
         vQD7XyDK23L3Z/xLtjQnE+IDM+1V05Vh0ISq3pwZKmDml245j3BzDC+eklyJhDcLDVrf
         lr91BrAkkJC/euJef77Dl7upNssH1PtqNPy7z8abSsn1aujKSZK6UAbaJQPgK71plD58
         a3lvFxhHOeHEzcuP+18uMK7lKi5ez4S+1+ngqgy6oJK2Sz2QY+RPr9D0bY3CdzJWsNor
         3SHw==
X-Gm-Message-State: APjAAAV41XtFipJs1QxJnBwWlIrMaELFJbBL3PW3aCbFtBwbKLbhVxb1
        u2G+t448+MG2GUBtcDk1uwFHjBnt2yHGLykZ9AqelAYYdGqPwiafnfYJJX/eJyXWKV9XE/b08Uw
        agpL0OLr8C/GawrvLvDLzZIO3
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3043326wmg.63.1582189762246;
        Thu, 20 Feb 2020 01:09:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuP2UdYyi73MjeE3vnzzNZI01MnvzA+dn9FFZ8I7LwiSQkzQOBin8Kub8QMd4N8L20So6CHQ==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3043309wmg.63.1582189762074;
        Thu, 20 Feb 2020 01:09:22 -0800 (PST)
Received: from [131.159.204.89] (w204-2h-v4.eduroam.dynamic.rbg.tum.de. [131.159.204.89])
        by smtp.gmail.com with ESMTPSA id m21sm3580891wmi.27.2020.02.20.01.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 01:09:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] virtio_balloon: Fix build error seen with CONFIG_BALLOON_COMPACTION=n
Date:   Thu, 20 Feb 2020 10:09:20 +0100
Message-Id: <48277641-3748-4EFD-BB19-ED5C9E06FDF2@redhat.com>
References: <20200220023156.20636-1-linux@roeck-us.net>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
In-Reply-To: <20200220023156.20636-1-linux@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 20.02.2020 um 03:32 schrieb Guenter Roeck <linux@roeck-us.net>:
>=20
> =EF=BB=BF0day reports:
>=20
> drivers//virtio/virtio_balloon.c: In function 'virtballoon_probe':
> drivers//virtio/virtio_balloon.c:960:1: error:
>    label 'out_del_vqs' defined but not used [-Werror=3Dunused-label]
>=20
> This is seen with CONFIG_BALLOON_COMPACTION=3Dn.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 1ad6f58ea936 ("virtio_balloon: Fix memory leaks on errors in virtba=
lloon_probe()")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

There is already a patch on the list to fix that (and it looks exactly like t=
his one :) ). Unfortunately, not picked up yet.

Thanks!=

