Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA0AC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A945F2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgAKJi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:38:56 -0500
Received: from [167.172.186.51] ([167.172.186.51]:44884 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728719AbgAKJiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:38:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4031EDF32F;
        Sat, 11 Jan 2020 09:39:00 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ya1nGhOda276; Sat, 11 Jan 2020 09:38:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5A32BDFCCC;
        Sat, 11 Jan 2020 09:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MVlENj0UXhEs; Sat, 11 Jan 2020 09:38:59 +0000 (UTC)
Received: from nedofet.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 02FE1DF32F;
        Sat, 11 Jan 2020 09:38:58 +0000 (UTC)
Message-ID: <8818b5338153790fc42d5b4d40cc7f061a6b861a.camel@v3.sk>
Subject: Re: [RESEND PATCH] iscsi_ibft: Don't limits Targets and NICs to two
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Peter Jones <pjones@redhat.com>, linux-kernel@vger.kernel.org
Date:   Sat, 11 Jan 2020 10:38:50 +0100
In-Reply-To: <20191230170340.GA23237@localhost.localdomain>
References: <20191221070956.268321-1-lkundrak@v3.sk>
         <20191230170340.GA23237@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-30 at 12:03 -0500, Konrad Rzeszutek Wilk wrote:
> On Sat, Dec 21, 2019 at 08:09:56AM +0100, Lubomir Rintel wrote:
> > According to iSCSI Boot Firmware Table Version 1.03 [1], the length of
> > the control table is ">= 18", where the optional expansion structure
> > pointer follow the mandatory ones. This allows for more than two NICs
> > and Targets.
> > 
> > [1] ftp://ftp.software.ibm.com/systems/support/bladecenter/iscsi_boot_firmware_table_v1.03.pdf
> > 
> > Let's enforce the minimum length of the control structure instead
> > instead of limiting it to the smallest allowed size.
> 
> Hi!
> 
> Do you have an example of such iBFT table? Thanks

Sorry for the late response, your message somehow slipped throught the
cracks during the holidays.

Please feed the following to "xxd -r". The md5sum is
991d671cc36367da6b104cce120a6048. You can test it with
"qemu -acpitable file=ibft.img".

00000000: 69 42 46 54 fb 02 00 00 01 d2 54 45 53 54 49 4e  iBFT......TESTIN
00000010: 54 45 53 54 00 00 00 00 00 00 00 00 00 00 00 00  TEST............
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000030: 01 01 16 00 00 00 00 00 48 00 98 00 d0 01 00 01  ........H.......
00000040: 08 02 68 01 40 02 00 00 02 01 4a 00 00 03 00 00  ..h.@.....J.....
00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 22 00  ..............".
00000090: 78 02 00 00 00 00 00 00 03 01 66 00 00 03 00 00  x.........f.....
000000a0: 00 00 00 00 00 00 00 00 ff ff c0 a8 32 65 18 03  ............2e..
000000b0: 00 00 00 00 00 00 00 00 00 00 ff ff c0 a8 32 01  ..............2.
000000c0: 00 00 00 00 00 00 00 00 00 00 ff ff c0 a8 32 01  ..............2.
000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
000000e0: 00 00 00 00 00 00 00 00 00 00 ff ff c0 a8 32 01  ..............2.
000000f0: 00 00 52 54 00 12 34 00 18 00 06 00 9b 02 00 00  ..RT..4.........
00000100: 03 01 66 00 01 03 00 00 00 00 00 00 00 00 00 00  ..f.............
00000110: ff ff c0 a8 33 65 18 03 00 00 00 00 00 00 00 00  ....3e..........
00000120: 00 00 ff ff c0 a8 33 01 00 00 00 00 00 00 00 00  ......3.........
00000130: 00 00 ff ff c0 a8 33 01 00 00 00 00 00 00 00 00  ......3.........
00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000150: 00 00 ff ff c0 a8 33 01 00 00 52 54 00 12 34 01  ......3...RT..4.
00000160: 20 00 06 00 a2 02 00 00 03 01 66 00 02 03 00 00   .........f.....
00000170: 00 00 00 00 00 00 00 00 ff ff c0 a8 34 65 18 03  ............4e..
00000180: 00 00 00 00 00 00 00 00 00 00 ff ff c0 a8 34 01  ..............4.
00000190: 00 00 00 00 00 00 00 00 00 00 ff ff c0 a8 34 01  ..............4.
000001a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
000001b0: 00 00 00 00 00 00 00 00 00 00 ff ff c0 a8 34 01  ..............4.
000001c0: 00 00 52 54 00 12 34 01 28 00 06 00 a9 02 00 00  ..RT..4.(.......
000001d0: 04 01 36 00 00 03 00 00 00 00 00 00 00 00 00 00  ..6.............
000001e0: ff ff c0 a8 32 01 bc 0c 00 01 00 00 00 00 00 00  ....2...........
000001f0: 00 00 18 00 b0 02 00 00 00 00 00 00 00 00 00 00  ................
00000200: 00 00 00 00 00 00 00 00 04 01 36 00 01 03 00 00  ..........6.....
00000210: 00 00 00 00 00 00 00 00 ff ff c0 a8 33 01 bc 0c  ............3...
00000220: 00 02 00 00 00 00 00 00 00 00 18 00 c9 02 00 00  ................
00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000240: 04 01 36 00 02 03 00 00 00 00 00 00 00 00 00 00  ..6.............
00000250: ff ff c0 a8 34 01 bc 0c 00 03 00 00 00 00 00 00  ....4...........
00000260: 00 00 18 00 e2 02 00 00 00 00 00 00 00 00 00 00  ................
00000270: 00 00 00 00 00 00 00 00 69 71 6e 2e 31 39 39 34  ........iqn.1994
00000280: 2d 30 35 2e 63 6f 6d 2e 72 65 64 68 61 74 3a 36  -05.com.redhat:6
00000290: 33 33 31 31 34 61 61 63 66 32 00 63 6c 69 65 6e  33114aacf2.clien
000002a0: 74 00 63 6c 69 65 6e 74 00 63 6c 69 65 6e 74 00  t.client.client.
000002b0: 69 71 6e 2e 32 30 30 39 2d 30 36 2e 74 65 73 74  iqn.2009-06.test
000002c0: 3a 74 61 72 67 65 74 30 00 69 71 6e 2e 32 30 30  :target0.iqn.200
000002d0: 39 2d 30 36 2e 74 65 73 74 3a 74 61 72 67 65 74  9-06.test:target
000002e0: 31 00 69 71 6e 2e 32 30 30 39 2d 30 36 2e 74 65  1.iqn.2009-06.te
000002f0: 73 74 3a 74 61 72 67 65 74 32 00                 st:target2.

Thanks
Lubo

> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/firmware/iscsi_ibft.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> > index 7e12cbdf957cc..96758b71a8db8 100644
> > --- a/drivers/firmware/iscsi_ibft.c
> > +++ b/drivers/firmware/iscsi_ibft.c
> > @@ -104,6 +104,7 @@ struct ibft_control {
> >  	u16 tgt0_off;
> >  	u16 nic1_off;
> >  	u16 tgt1_off;
> > +	u16 expansion[0];
> >  } __attribute__((__packed__));
> >  
> >  struct ibft_initiator {
> > @@ -235,7 +236,7 @@ static int ibft_verify_hdr(char *t, struct ibft_hdr *hdr, int id, int length)
> >  				"found %d instead!\n", t, id, hdr->id);
> >  		return -ENODEV;
> >  	}
> > -	if (hdr->length != length) {
> > +	if (length && hdr->length != length) {
> >  		printk(KERN_ERR "iBFT error: We expected the %s " \
> >  				"field header.length to have %d but " \
> >  				"found %d instead!\n", t, length, hdr->length);
> > @@ -749,16 +750,16 @@ static int __init ibft_register_kobjects(struct acpi_table_ibft *header)
> >  	control = (void *)header + sizeof(*header);
> >  	end = (void *)control + control->hdr.length;
> >  	eot_offset = (void *)header + header->header.length - (void *)control;
> > -	rc = ibft_verify_hdr("control", (struct ibft_hdr *)control, id_control,
> > -			     sizeof(*control));
> > +	rc = ibft_verify_hdr("control", (struct ibft_hdr *)control, id_control, 0);
> >  
> >  	/* iBFT table safety checking */
> >  	rc |= ((control->hdr.index) ? -ENODEV : 0);
> > +	rc |= ((control->hdr.length < sizeof(*control)) ? -ENODEV : 0);
> >  	if (rc) {
> >  		printk(KERN_ERR "iBFT error: Control header is invalid!\n");
> >  		return rc;
> >  	}
> > -	for (ptr = &control->initiator_off; ptr < end; ptr += sizeof(u16)) {
> > +	for (ptr = &control->initiator_off; ptr + sizeof(u16) <= end; ptr += sizeof(u16)) {
> >  		offset = *(u16 *)ptr;
> >  		if (offset && offset < header->header.length &&
> >  						offset < eot_offset) {
> > -- 
> > 2.24.1
> > 

