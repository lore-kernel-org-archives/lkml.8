Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6CC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429F21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJ3XuwMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgATNPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:15:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56665 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgATNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579526149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lf+TJXDtlpY1pLKgkkU89rddl+SS/0hPfh7anuZY6s=;
        b=SJ3XuwMDxY3AqoxymeIRHLoFPA4Hb/X+5pw+cxwBQGwThnEwFto569WaL5C719VemZD4Il
        mqp53DqC+fhPI7Wl3iSMOPoqvSXPqvaHo3N8stXmnF+gq0ihhhL4GiS5/IvMs+Ez7UFpVe
        W1p4Zi49bG54nviqFzftejO38dO0VxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-jujFIrIBOQy1v6cv6l-gZw-1; Mon, 20 Jan 2020 08:15:46 -0500
X-MC-Unique: jujFIrIBOQy1v6cv6l-gZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106F8DBA3;
        Mon, 20 Jan 2020 13:15:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2CB45D9E2;
        Mon, 20 Jan 2020 13:15:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200120082335.GD21151@kadam>
References: <20200120082335.GD21151@kadam> <0000000000001a91f9059c52f727@google.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+afeecc39f502a8681560@syzkaller.appspotmail.com>,
        arnd@arndb.de, dmitry.torokhov@gmail.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Subject: Re: linux-next boot error: KASAN: slab-out-of-bounds Read in post_usb_notification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <929067.1579526141.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 20 Jan 2020 13:15:41 +0000
Message-ID: <929068.1579526141@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

>   2759          struct {
>   2760                  struct usb_notification n;
>   2761                  char more_name[USB_NOTIFICATION_MAX_NAME_LEN -
>   2762                                 (sizeof(struct usb_notification) =
-
>   2763                                  offsetof(struct usb_notification=
, name))];
>   2764          } n;
>   2765  =

>   2766          name_len =3D strlen(devname);
>   2767          name_len =3D min_t(size_t, name_len, USB_NOTIFICATION_MA=
X_NAME_LEN);
>                                                    ^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^
> This limit is too high.  It should be USB_NOTIFICATION_MAX_NAME_LEN -
> sizeof(struct usb_notification). or just
> "min_t(size_t, name_len, sizeof(n.more_name));".  n.n.name[] is a
> zero size array.

No.  It's not that simple.  If you look at the struct:

	struct usb_notification {
		struct watch_notification watch;
		__u32	error;
		__u32	reserved;
		__u8	name_len;
		__u8	name[0];
	};

There are at least 3, if not 7, bytes of padding after name[] as the struc=
t is
not packed - and isn't necessarily rounded up to a multiple of 8 bytes eit=
her.
If you look at the definition of more_name[] above, you'll see:

	USB_NOTIFICATION_MAX_NAME_LEN -
	(sizeof(struct usb_notification) -
	 offsetof(struct usb_notification, name))

That calculates the amount of padding and then subtracts it from the amoun=
t of
name bufferage required.

USB_NOTIFICATION_MAX_NAME_LEN is 63, which is 64 minus one for the length.

>   2771          memcpy(n.n.name, devname, n_len);
>                                           ^^^^^
> name_len was intended here.

Yeah.  I think that's actually the bug.  n_len is the length of the entire
notification record.

David

