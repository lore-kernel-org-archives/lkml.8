Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A98B2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Edx72yWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbgFWO2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:28:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732730AbgFWO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=beTDetm7uJONb4wWWHqCX7gpSoHKePlgANzqtDZNtLA=;
        b=Edx72yWWAkT17CILHyJILzYrqwXLzAPR4uQSJgNFR3J2WvldahRc5VT3Fnf1zadPDvQAP+
        NeAD1iGe/q4p00NFPszPiPWUQuZkxshC6wvN6oHIYwfQTLkNXNFnCKILufQTcJt8jZMC3N
        JvORksBuFHJLtF88EartN4Fm/IxjEqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-IQO2MB72PX-XkvBVPEHaoQ-1; Tue, 23 Jun 2020 10:27:55 -0400
X-MC-Unique: IQO2MB72PX-XkvBVPEHaoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A99D68018AB;
        Tue, 23 Jun 2020 14:27:54 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A03B27CCC0;
        Tue, 23 Jun 2020 14:27:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8 resend] virt: vbox: Add support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
Date:   Tue, 23 Jun 2020 16:27:44 +0200
Message-Id: <20200623142752.4331-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

<Resend, for some reason after updating git my git send-email all of a
 sudden send each patch seperately instead of making all mails part of the
 same email thread, that is hopefully fixed now.>

Here is v2 of my vboxguest driver patch-set adding support for the
new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl which is necessary to
make guest resizing work with the new(ish) VMSVGA emulation in vbox +
some other small fixes.

The only change since v2 is rate-limiting the error-logging in:
[PATCH v2 7/8] virt: vbox: Log unknown ioctl requests as error

Regards,

Hans

