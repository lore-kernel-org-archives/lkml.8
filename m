Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4AC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C3F20873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1TR2Vha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgBKNFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:05:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728666AbgBKNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581426304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kqt8vtCIW6YAIOlkwJ37g/dGZjDycn7sBle2ILD4zxA=;
        b=K1TR2VhauB2Ac8/lRUTAETuWjv6dBMcDNwnK6pTEZUfQFQT5lXci7b3G+++NGk1dmfOEA5
        BhquhczuhYUmjovoKlLar4tXlsOK5BC/GR3wNKvJByu9hpuJCQ6P8OV2GEkQ+uowfKljHF
        B8A3ClcDUyAWzzSJCmNWPOJY4LU+Wdk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-IN9D-TaPMEaCInMBS0X4hA-1; Tue, 11 Feb 2020 08:05:00 -0500
X-MC-Unique: IN9D-TaPMEaCInMBS0X4hA-1
Received: by mail-wr1-f70.google.com with SMTP id p8so6816661wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kqt8vtCIW6YAIOlkwJ37g/dGZjDycn7sBle2ILD4zxA=;
        b=c2D23an6ku447XhlJNs0D52jnIoRNeHzGYzAeFpyajmVlpPAGd/f5UZ3IM3RBbRoiy
         gDr1AI3zlfxzfK24kIFxbdRNmeRv4l2e3ieYAh2oH7gYhUevOMdMRtuA8WwkF9NFvRP5
         +igVskc+PxWLgfXBlXjxXTQaAmcay8UjIBbDskckXOng698tZCS2CzC5y+rIvr7gdSy8
         2Qqzzxsd0X2NsykI6fOoamMEB90r6o1f2QHCJ0TDVzT8PgbVSBXI8c1vvJnv9YLJj7iM
         QfKvd+OHch3R+BCmAoGeNmG1YbnPjiLuk7IdUc+gWPP2L094VWtXK9SCD8276W0EQh4U
         kUqg==
X-Gm-Message-State: APjAAAWS9pV2Wzg/pHTektHYB3wu5YYyHOcPMqC6ehsjT2Do/q18clgI
        o5n+81kmOhqDqpJGcKUaSjRMPa+E3WIZfTzAhWt6Yf6JyFlOn8rNmriaFXUTMZ9nQ4V2NfgNkGA
        StXkxaSTjgaDUY6yyyJdOAy2F
X-Received: by 2002:a1c:6755:: with SMTP id b82mr5319148wmc.127.1581426299276;
        Tue, 11 Feb 2020 05:04:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmKyPbRozPTEG8zxNdGYI5O2FSVLwMWkgPtbCQkwJ3DD9ducdeXjnrmKcGk+ai79rusLwduw==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr5319012wmc.127.1581426297509;
        Tue, 11 Feb 2020 05:04:57 -0800 (PST)
Received: from eperezma.remote.csb (121.142.221.87.dynamic.jazztel.es. [87.221.142.121])
        by smtp.gmail.com with ESMTPSA id o2sm3531044wmh.46.2020.02.11.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:04:57 -0800 (PST)
Message-ID: <e299afca8e22044916abbf9fbbd0bff6b0ee9e13.camel@redhat.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger
 random crashes in KVM guests after reboot
From:   Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Date:   Tue, 11 Feb 2020 14:04:54 +0100
In-Reply-To: <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
References: <20200107042401-mutt-send-email-mst@kernel.org>
         <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
         <20200107065434-mutt-send-email-mst@kernel.org>
         <fe6e7e90-3004-eb7a-9ed8-b53a7667959f@de.ibm.com>
         <20200120012724-mutt-send-email-mst@kernel.org>
         <2a63b15f-8cf5-5868-550c-42e2cfd92c60@de.ibm.com>
         <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
         <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
         <20200206171349-mutt-send-email-mst@kernel.org>
         <5c860fa1-cef5-b389-4ebf-99a62afa0fe8@de.ibm.com>
         <20200207025806-mutt-send-email-mst@kernel.org>
         <97c93d38-ef07-e321-d133-18483d54c0c0@de.ibm.com>
         <CAJaqyWfngzP4d01B6+Sqt8FXN6jX7kGegjx8ie4no_1Er3igQA@mail.gmail.com>
         <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-6.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 12:01 +0100, Christian Borntraeger wrote:
> 
> On 10.02.20 10:47, Eugenio Perez Martin wrote:
> > Hi Christian.
> > 
> > I'm not able to reproduce the failure with eccb852f1fe6bede630e2e4f1a121a81e34354ab commit. Could you add more data?
> > Your configuration (libvirt or qemu line), and host's dmesg output if any?
> > 
> > Thanks!
> 
> If it was not obvious, this is on s390x, a big endian system.
> 

Hi Christian. Thank you very much for your fast responses.

Could you try this patch on top of eccb852f1fe6bede630e2e4f1a121a81e34354ab?

Thanks!

From 71d0f9108a18aa894cc0c0c1c7efbad39f465a27 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <
eperezma@redhat.com>
Date: Tue, 11 Feb 2020 13:19:10 +0100
Subject: [PATCH] vhost: fix return value of vhost_get_vq_desc

Before of the batch change, it was the chain's head. Need to keep that
way or we will not be able to free a chain of descriptors.

Fixes: eccb852f1fe6 ("vhost: batching fetches")
---
 drivers/vhost/vhost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b5a51b1f2e79..fc422c3e5c08 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2409,12 +2409,11 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 			*out_num += ret;
 		}
 
-		ret = desc->id;
-
 		if (!(desc->flags & VRING_DESC_F_NEXT))
 			break;
 	}
 
+	ret = vq->descs[vq->first_desc].id;
 	vq->first_desc = i + 1;
 
 	return ret;
-- 
2.18.1

