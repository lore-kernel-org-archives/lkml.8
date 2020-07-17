Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF296C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C871F204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnwuGEub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgGQLmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:42:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594986126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DRiVIwwbVSKtgxI8TX4xFnXUWovJnEvT90U/53wTUHc=;
        b=FnwuGEub4p1PFZpxmnlsSu1ygjfES17PxMyIs7uEnxFsg562PFCCQIUkhEfvaFnu2qxhEC
        5UKqtD8j2lsbfrSp/FULp2O44bOWQDctLjWO5MTQcWGvjBWD77Eael1LY9SqtYFt+ohzh0
        i+LaSPM/YB1LvopsBbGCAjko6joMh/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-sTpDt9yjO8OE8l5xBV1NxQ-1; Fri, 17 Jul 2020 07:42:02 -0400
X-MC-Unique: sTpDt9yjO8OE8l5xBV1NxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DC5580183C;
        Fri, 17 Jul 2020 11:42:00 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-162.ams2.redhat.com [10.36.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA6947950A;
        Fri, 17 Jul 2020 11:41:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        Marco Trevisan <marco.trevisan@canonical.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Christian Kellner <ckellner@redhat.com>,
        Benjamin Berg <bberg@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add 3 new keycodes and use them for 3 new hotkeys on new Lenovo Thinkpads
Date:   Fri, 17 Jul 2020 13:41:52 +0200
Message-Id: <20200717114155.56222-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is a simple patch-series adding support for 3 new hotkeys found
on various new Lenovo Thinkpad models.

There is one small complication, these 3 new hotkeys also require
the addition of new key-codes to include/uapi/linux/input-event-codes.h.

And those changes have to land first. It is probably easiest to just
merge everything through the platform/x86 tree, or alternatively we
would need an immutable branch from the input-subsys with the first
patch on there which the platform/x86 maintainers can then merge.

Dmitry, can you please let us know how you want to proceed with these
changes; And if you are ok with merging the input-event-codes.h changes
through the platform/x86 tree, may we have your Acked-by for that ?

Regards,

Hans

