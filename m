Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED55C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852CF20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF6IMSIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbgDBOqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:46:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388266AbgDBOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585838802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=247fWnWaIxGLXiVh3d5vG20xrpndo7qpcBC/YB6ZW/8=;
        b=MF6IMSIXyQzG4ZB8BmyeYC4CnmdU5FK1Qrj73kk9Tm64MrOaJHBRpbAyletLdL66B7gVzf
        jesn98nDDbI6brVqK6Uf9aGGT4n9Nq5Vw/7N5l3HkrRd5p6B80001Pm4ecu67CjFDeTWbR
        gVKq/QDRL/lMctfh55BLg1/2QpjtOqU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-nEPZGDqZNdm6zXPtLlSBkg-1; Thu, 02 Apr 2020 10:46:40 -0400
X-MC-Unique: nEPZGDqZNdm6zXPtLlSBkg-1
Received: by mail-qk1-f198.google.com with SMTP id y5so3226406qky.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=247fWnWaIxGLXiVh3d5vG20xrpndo7qpcBC/YB6ZW/8=;
        b=rwBPV3F8FyuUF+305XTjYP3FGCEPKkaDrosob/SiU5YcdKk1kZc0GEh81gOj4j0rfe
         Jnd9EYHRUOFZL2am827n30wU9SHyLpYNBwIBVTq79vDgbVqULTvoTcJqc8qc5q2nyfg6
         W3uDe3dq81AMEZPgEIDijQBuHSEYVn72E82Tbk2LbwOTrEKRY1VIl7G2B3qyy94BK8/Z
         if69chadbK5Dn/T3dr6L3uJnMxbj/A8sY+vux7lUA+g5O5m4lcIT+Jn3Q4sakdC9K3wG
         Qkvg696SEZKTAe/vrPBzcTGef3ccmX18nDnEINwZbN9/CN8s437bOc9aOHRal6SDV8wB
         bR8Q==
X-Gm-Message-State: AGi0PubeEsrs1ZzJmLYJ3feEppO4+RN/0mFHhD4nEVPEHX/9dgDL93q5
        z/2wo6W8inW+zFZdp2vljloI+iYd/NEofQBGj5XesSifKuXL28S44yB0Na1mrUQoVBym3zgFtQ2
        jOV1o2HWDdmOzfoT6I3/hPjVV
X-Received: by 2002:ae9:dd83:: with SMTP id r125mr3878508qkf.105.1585838799303;
        Thu, 02 Apr 2020 07:46:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJrCvrYOfccOPc0wjpUe4Jhvl0Nl/n0u9FB6DDdrO18srx7Gu82PDrBByu2qXM5kAyNldGtag==
X-Received: by 2002:ae9:dd83:: with SMTP id r125mr3878453qkf.105.1585838798775;
        Thu, 02 Apr 2020 07:46:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id p9sm3672571qtu.3.2020.04.02.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:46:37 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:46:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2] vhost: drop vring dependency on iotlb
Message-ID: <20200402144519.34194-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vringh can now be built without IOTLB.
Select IOTLB directly where it's used.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Applies on top of my vhost tree.
Changes from v1:
	VDPA_SIM needs VHOST_IOTLB

 drivers/vdpa/Kconfig  | 1 +
 drivers/vhost/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 7db1460104b7..08b615f2da39 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -17,6 +17,7 @@ config VDPA_SIM
 	depends on RUNTIME_TESTING_MENU
 	select VDPA
 	select VHOST_RING
+	select VHOST_IOTLB
 	default n
 	help
 	  vDPA networking device simulator which loop TX traffic back
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index f0404ce255d1..cb6b17323eb2 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -8,7 +8,6 @@ config VHOST_IOTLB
 
 config VHOST_RING
 	tristate
-	select VHOST_IOTLB
 	help
 	  This option is selected by any driver which needs to access
 	  the host side of a virtio ring.
-- 
MST

