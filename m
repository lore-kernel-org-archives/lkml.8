Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFDC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82AB20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQtCxkPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCEP5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:57:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55785 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgCEP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583423833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IxoeEnt35O7QTmRZWyr2gwugnfgn2HRJVIdogRILp7k=;
        b=dQtCxkPub7SE1lGVzRmyEOJVXWbvZq/fj+FaEgtuHOc1UIPfOUcI3TJKJ5b7A6bvQTUAC+
        WYxzAMSSR46DhjqGNtRHQLuEFud0jr/pSwTioQHRSAtVk4vufNBD1yhVsk4fFsUk4+7vz5
        4JWEdOTlBIqJEsEcz8dFYdCz9ZNmlXY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-fVWFhz8KPYCVk1dJffZHUg-1; Thu, 05 Mar 2020 10:57:11 -0500
X-MC-Unique: fVWFhz8KPYCVk1dJffZHUg-1
Received: by mail-qv1-f69.google.com with SMTP id h17so3267651qvc.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxoeEnt35O7QTmRZWyr2gwugnfgn2HRJVIdogRILp7k=;
        b=kOxAnYaUyryRSlIHBqVt/erBgtSi10BroS7OYQYuaPbJZgx3RvPJejy7quaAW/8xky
         QE1fahkH10/NL5jUPao077A1RoXsehUzqNhOvOfXciBgMLk3tiUyWI/NuOHqrn82hsnc
         4EI1q9UafjRKaoWSOFeng1OsgiApbsiU1z3d+nXO3wyelUai15Wq60QGtLztka4IX6oL
         dqBc+ANR9t31+oe4NZ4N8CozsQhtYynszcRl+CJF10tYZxUXqdIGcc58VSuJe/Bjc4mH
         tG20nJbKh/fYpI2/HGVx6Nor1CKKikMlaUMkjqE6l/j49W3Hx07+bOiNIXHvfBMnOpfV
         1dzQ==
X-Gm-Message-State: ANhLgQ2HEqHQZoGQmej3DCczihynP+CZ4hRjedCvChHU0lFsYzw4rkoJ
        Cgno4rAEr8d+DiP2nX84xm/wxMIDDoACQ+Jdxi4pUbMH9nNPLJiKq4MvOxhDXBU8iiEvj/KEJ+F
        7qJ2WcJzkGpOoSBzY01snUkvv
X-Received: by 2002:a37:6258:: with SMTP id w85mr9019906qkb.206.1583423831400;
        Thu, 05 Mar 2020 07:57:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsWJ9ChA7AqjC8mi6Y+3B8RoMTG+j/4BpcKmFtJ6GioCGLGAqBL5bV82PTSSCUwsx+KztqSCw==
X-Received: by 2002:a37:6258:: with SMTP id w85mr9019888qkb.206.1583423831166;
        Thu, 05 Mar 2020 07:57:11 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a18sm14815053qkg.48.2020.03.05.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:57:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmiaohe@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
        peterx@redhat.com
Subject: [PATCH v2 0/2] KVM: Drop gfn_to_pfn_atomic()
Date:   Thu,  5 Mar 2020 10:57:07 -0500
Message-Id: <20200305155709.118503-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:=0D
- add a document update for indirect sp fast path which referenced=0D
  gfn_to_pfn_atomic(). [linmiaohe]=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (2):=0D
  KVM: Documentation: Update fast page fault for indirect sp=0D
  KVM: Drop gfn_to_pfn_atomic()=0D
=0D
 Documentation/virt/kvm/locking.rst | 9 ++++-----=0D
 include/linux/kvm_host.h           | 1 -=0D
 virt/kvm/kvm_main.c                | 6 ------=0D
 3 files changed, 4 insertions(+), 12 deletions(-)=0D
=0D
-- =0D
2.24.1=0D
=0D

