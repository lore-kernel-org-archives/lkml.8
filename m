Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA0C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB0C20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sqv1o01C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgC1P16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:27:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39803 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgC1P15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585409276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EtA1cUZ/YAmxg9mcoqMJAMjtt//Xv/eQ1J1VjHAqAgQ=;
        b=Sqv1o01CqNXtb+Heor1vMoy717RSHZtQn74UmkOO7Rq4X8jsQaEz1x6FKwDX5D7yJgGwVd
        8QkHugtg+Bl0L3OC0AO253K4L8LRm1xplEOxJN4Gw9jktXBq2Gde8T8sRnujpefAV/rkjM
        5LoU+KjgE7aLCY5Um0T+5S68Gg3NrPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-JI9f35o1Oe2AjDn9PWvzXw-1; Sat, 28 Mar 2020 11:27:54 -0400
X-MC-Unique: JI9f35o1Oe2AjDn9PWvzXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8530F8017CE;
        Sat, 28 Mar 2020 15:27:52 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BD0660C63;
        Sat, 28 Mar 2020 15:27:52 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5615442FE774; Sat, 28 Mar 2020 12:27:27 -0300 (-03)
Message-ID: <20200328152503.271570281@redhat.com>
User-Agent: quilt/0.66
Date:   Sat, 28 Mar 2020 12:21:20 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 3/3] isolcpus: undeprecate on documentation
References: <20200328152117.881555226@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isolcpus is used to control steering of interrupts to managed_irqs and
kernel threads, therefore its incorrect to state that its deprecated.

Remove deprecation warning.

Suggested-by: Chris Friesen <chris.friesen@windriver.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 Documentation/admin-guide/kernel-parameters.txt |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
@@ -1926,7 +1926,6 @@
 			Format: <RDP>,<reset>,<pci_scan>,<verbosity>
 
 	isolcpus=	[KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
-			[Deprecated - use cpusets instead]
 			Format: [flag-list,]<cpu-list>
 
 			Specify one or more CPUs to isolate from disturbances


