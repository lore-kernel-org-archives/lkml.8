Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA0FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086D920738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8PQhShv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgFBQ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:28:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24339 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgFBQ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591115288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tyM2BxulV0HOmx/+JvhObFxHlx66m4jLAl+vy1rTPos=;
        b=i8PQhShvhmYsiaLW1FErSyifHuea2R2/UXSwoZZ6dE/g53CnchDuNz99VYJdx68ABy/2xV
        Kj+fUup0erNjX1dYavVPpYxgscPzsBmAENdB/5fxsl8aEOglobtWJufNl3BUsic7bkK68w
        GlOuOHcjz9YTouDnV0ADEktO5G/5riM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-kG2CUa-4OCCPoUv3zDEIHA-1; Tue, 02 Jun 2020 12:28:06 -0400
X-MC-Unique: kG2CUa-4OCCPoUv3zDEIHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C599800053;
        Tue,  2 Jun 2020 16:28:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C71D6116F;
        Tue,  2 Jun 2020 16:28:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        mathstuf@gmail.com, gustavoars@kernel.org, Jason@zx2c4.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] keys: Changes for 5.8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1509350.1591115280.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Jun 2020 17:28:00 +0100
Message-ID: <1509351.1591115280@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you pull these keyrings fixes please?

 (1) Fix a documentation warning.

 (2) Replace a [0] array with [].

 (3) Make the big_key key type use ChaCha20Poly1305 and use the crypto
     algorithm directly rather than going through the crypto layer.

 (4) Implement the update op for the big_key type.

Thanks,
David
---
The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4=
c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/keys-next-20200602

for you to fetch changes up to b6f61c31464940513ef4eccb3a030a405b4256d6:

  keys: Implement update for the big_key type (2020-06-02 17:22:31 +0100)

----------------------------------------------------------------
Keyrings changes

----------------------------------------------------------------
Ben Boeckel (1):
      Documentation: security: core.rst: add missing argument

David Howells (1):
      keys: Implement update for the big_key type

Gustavo A. R. Silva (1):
      KEYS: Replace zero-length array with flexible-array

Jason A. Donenfeld (1):
      security/keys: rewrite big_key crypto to use library interface

 Documentation/security/keys/core.rst |   8 +-
 include/keys/big_key-type.h          |   1 +
 include/keys/user-type.h             |   2 +-
 security/keys/Kconfig                |   4 +-
 security/keys/big_key.c              | 257 +++++++-----------------------=
-----
 5 files changed, 60 insertions(+), 212 deletions(-)

