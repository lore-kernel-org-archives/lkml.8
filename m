Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DE6C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F2E20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqoQIh/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgBEPeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:34:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21058 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgBEPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580916875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TyY0bw5BSjDw9i9Jna6kHj7htq0ZCBLkIM5aQY6kQxU=;
        b=TqoQIh/8zG5kuzUnnVGx0Sgtfq9uDSFzZiHUBlFQ/6aJdPT4RSQzBX2FfSS/LCCJRbHeon
        llAaMDWsqveGuu+21F4Z9a0qJK4Z3AKVb3AGmfH+Hgh5t7bA7McC0WsX81W/XsrqKbvuPZ
        ZMFfWvn8ZclrtRMpmkNpSNskL3fXgR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-2J8eojHNN0m8FjrfGbJ0GQ-1; Wed, 05 Feb 2020 10:34:34 -0500
X-MC-Unique: 2J8eojHNN0m8FjrfGbJ0GQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 182998010CB;
        Wed,  5 Feb 2020 15:34:32 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-179.ams2.redhat.com [10.36.116.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DECE8857B5;
        Wed,  5 Feb 2020 15:34:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Vipul Kumar <vipulk0511@gmail.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Len Brown <len.brown@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] x86/tsc_msr: Make MSR derived TSC frequency more accurate
Date:   Wed,  5 Feb 2020 16:34:25 +0100
Message-Id: <20200205153428.437087-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Andy has contacted me offlist that he has been unable to find any docks
specifying where the existing Merrifield and Moorefield numbers come from
as such I believe that it is best to keep the table with multiplier/divid=
er
pairs per model even though there is some overlap.

This v2 of the patch set fixes a typo in the commit message / added comme=
nts
and fixes my mistake of referring to Merrifield/Moorefield as BYT/CHT in =
a
comment, which they are not.

Unless someone else has a better/cleaner idea to fix this, I believe that
this series is ready for merging now.

Regards,

Hans

