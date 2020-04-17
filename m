Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C65C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC272137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MFmB/hNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgDQHxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:53:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36074 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729042AbgDQHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:53:00 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H7pvVk017876;
        Fri, 17 Apr 2020 09:52:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=LnEZiGg0HawGS2IYhuq2ciadc1KDjWuAyQRSTEFNgp4=;
 b=MFmB/hNUS57WzHXnZqLc8bIcGJWnEU3YJjmuB4Deo2XhBkm3TKiTNqO07qC5DDsTwtMq
 MMYeHIYBS6AJCCwYGrFIRXwyvLRnGEFwva8/XDv3Nv7LEDOynzmjjvIYtdxWd6jq1zuy
 yz80QslbnHCa232jgEcXn70uSKUAB5FhhzYf/n9+i3rnEasSLgvObD3+4Q94y2vbsH+3
 2CQmwEjGL71UYSmtkr0qfri6Io4g2Qp8n3SJu0SbLNmQYiZz0ot7Xpzulsd82233QBJs
 plUVlBCyssul3Enus28FgHRrcceHZwef13ukZpt6fl1rqnjqY2i4oOTjoTdEtwSTroup IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn75yvku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:52:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8119710002A;
        Fri, 17 Apr 2020 09:52:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5AA032A67B1;
        Fri, 17 Apr 2020 09:52:51 +0200 (CEST)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 09:52:50 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Fri, 17 Apr 2020 09:52:50 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "sidgup@codeaurora.org" <sidgup@codeaurora.org>
Subject: RE: [PATCH 2/3] remoteproc: Add inline coredump functionality
Thread-Topic: [PATCH 2/3] remoteproc: Add inline coredump functionality
Thread-Index: AQHWFB6Px5XANSHAy0ChO/Yg4pxMuah88WJw
Date:   Fri, 17 Apr 2020 07:52:50 +0000
Message-ID: <1b85229632dd44f198b3e0ff9414b458@SFHDAG7NODE2.st.com>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_02:2020-04-14,2020-04-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> owner@vger.kernel.org> On Behalf Of Rishabh Bhatnagar
> Sent: jeudi 16 avril 2020 20:39
> To: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bjorn.andersson@linaro.org; ohad@wizery.com;
> mathieu.poirier@linaro.org; tsoni@codeaurora.org;
> psodagud@codeaurora.org; sidgup@codeaurora.org; Rishabh Bhatnagar
> <rishabhb@codeaurora.org>
> Subject: [PATCH 2/3] remoteproc: Add inline coredump functionality
>=20
> This patch adds the inline coredump functionality. The current
> coredump implementation uses vmalloc area to copy all the segments.
> But this might put a lot of strain on low memory targets as the
> firmware size sometimes is in ten's of MBs. The situation becomes
> worse if there are multiple remote processors  undergoing recovery
> at the same time. This patch directly copies the device memory to
> userspace buffer and avoids extra memory usage. This requires
> recovery to be halted until data is read by userspace and free
> function is called.
>=20
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_coredump.c | 130
> +++++++++++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h |  23 +++++-
>  include/linux/remoteproc.h               |   2 +
>  3 files changed, 153 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/remoteproc/remoteproc_coredump.c
> b/drivers/remoteproc/remoteproc_coredump.c
> index 9de0467..888b7dec91 100644
> --- a/drivers/remoteproc/remoteproc_coredump.c
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -12,6 +12,84 @@
>  #include <linux/remoteproc.h>
>  #include "remoteproc_internal.h"
>=20
> +static void rproc_free_dump(void *data)
> +{
> +	struct rproc_coredump_state *dump_state =3D data;
> +
> +	complete(&dump_state->dump_done);
> +}
> +
> +static unsigned long resolve_addr(loff_t user_offset,
> +				   struct list_head *segments,
> +				   unsigned long *data_left)
> +{
> +	struct rproc_dump_segment *segment;
> +
> +	list_for_each_entry(segment, segments, node) {
> +		if (user_offset >=3D segment->size)
> +			user_offset -=3D segment->size;
> +		else
> +			break;
> +	}
> +
> +	if (&segment->node =3D=3D segments) {
> +		*data_left =3D 0;
> +		return 0;
> +	}
> +
> +	*data_left =3D segment->size - user_offset;
> +
> +	return segment->da + user_offset;
> +}
> +
> +static ssize_t rproc_read_dump(char *buffer, loff_t offset, size_t count=
,
> +				void *data, size_t header_size)
> +{
> +	void *device_mem;
> +	size_t data_left, copy_size, bytes_left =3D count;
> +	unsigned long addr;
> +	struct rproc_coredump_state *dump_state =3D data;
> +	struct rproc *rproc =3D dump_state->rproc;
> +	void *elfcore =3D dump_state->header;
> +
> +	/* Copy the header first */
> +	if (offset < header_size) {
> +		copy_size =3D header_size - offset;
> +		copy_size =3D min(copy_size, bytes_left);
> +
> +		memcpy(buffer, elfcore + offset, copy_size);
> +		offset +=3D copy_size;
> +		bytes_left -=3D copy_size;
> +		buffer +=3D copy_size;
> +	}
> +
> +	while (bytes_left) {
> +		addr =3D resolve_addr(offset - header_size,
> +				    &rproc->dump_segments, &data_left);
> +		/* EOF check */
> +		if (data_left =3D=3D 0) {
> +			pr_info("Ramdump complete %lld bytes read",
> offset);
> +			break;
> +		}
> +
> +		copy_size =3D min_t(size_t, bytes_left, data_left);
> +
> +		device_mem =3D rproc->ops->da_to_va(rproc, addr,
> copy_size);
> +		if (!device_mem) {
> +			pr_err("Address:%lx with size %zd out of remoteproc
> carveout\n",
> +				addr, copy_size);
> +			return -ENOMEM;
> +		}
> +		memcpy(buffer, device_mem, copy_size);
> +
> +		offset +=3D copy_size;
> +		buffer +=3D copy_size;
> +		bytes_left -=3D copy_size;
> +	}
> +
> +	return count - bytes_left;
> +}
> +
>  static void create_elf_header(void *data, int phnum, struct rproc *rproc=
)
>  {
>  	struct elf32_phdr *phdr;
> @@ -55,6 +133,58 @@ static void create_elf_header(void *data, int phnum,
> struct rproc *rproc)
>  }
>=20
>  /**
> + * rproc_inline_coredump() - perform synchronized coredump
> + * @rproc:	rproc handle
> + *
> + * This function will generate an ELF header for the registered segments
> + * and create a devcoredump device associated with rproc. This function
> + * directly copies the segments from device memory to userspace. The
> + * recovery is stalled until the enitire coredump is read. This approach
Typo entire -> entire
> + * avoids using extra vmalloc memory(which can be really large).
> + */
> +void rproc_inline_coredump(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *segment;
> +	struct elf32_phdr *phdr;
> +	struct elf32_hdr *ehdr;
> +	struct rproc_coredump_state *dump_state;
> +	size_t header_size;
> +	void *data;
> +	int phnum =3D 0;
> +
> +	if (list_empty(&rproc->dump_segments))
> +		return;
> +
> +	header_size =3D sizeof(*ehdr);
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		header_size +=3D sizeof(*phdr);
> +
> +		phnum++;
> +	}
> +
> +	data =3D vmalloc(header_size);
> +	if (!data)
> +		return;
> +
> +	ehdr =3D data;
> +	create_elf_header(data, phnum, rproc);
> +
> +	dump_state =3D kzalloc(sizeof(*dump_state), GFP_KERNEL);
> +	dump_state->rproc =3D rproc;
> +	dump_state->header =3D data;
> +	init_completion(&dump_state->dump_done);
> +
> +	dev_coredumpm(&rproc->dev, NULL, dump_state, header_size,
> GFP_KERNEL,
> +		      rproc_read_dump, rproc_free_dump);
> +
> +	/* Wait until the dump is read and free is called */
> +	wait_for_completion(&dump_state->dump_done);

Maybe good to add a timeout with value programmable via debugfs?

Regards,
Loic
> +
> +	kfree(dump_state);
> +}
> +EXPORT_SYMBOL(rproc_inline_coredump);
> +
> +/**
>   * rproc_default_coredump() - perform coredump
>   * @rproc:	rproc handle
>   *
> diff --git a/drivers/remoteproc/remoteproc_internal.h
> b/drivers/remoteproc/remoteproc_internal.h
> index 28b6af2..ea6146e 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -24,6 +24,18 @@ struct rproc_debug_trace {
>  	struct rproc_mem_entry trace_mem;
>  };
>=20
> +struct rproc_coredump_state {
> +	struct rproc *rproc;
> +	void *header;
> +	struct completion dump_done;
> +};
> +
> +enum rproc_coredump_conf {
> +	COREDUMP_DEFAULT,
> +	COREDUMP_INLINE,
> +	COREDUMP_DISABLED,
> +};
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> @@ -49,6 +61,7 @@ struct dentry *rproc_create_trace_file(const char
> *name, struct rproc *rproc,
>=20
>  /* from remoteproc_coredump.c */
>  void rproc_default_coredump(struct rproc *rproc);
> +void rproc_inline_coredump(struct rproc *rproc);
>=20
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> @@ -125,8 +138,14 @@ struct resource_table
> *rproc_find_loaded_rsc_table(struct rproc *rproc,
>  static inline
>  void rproc_coredump(struct rproc *rproc)
>  {
> -	return rproc_default_coredump(rproc);
> -
> +	switch (rproc->coredump_conf) {
> +	case COREDUMP_DEFAULT:
> +		return rproc_default_coredump(rproc);
> +	case COREDUMP_INLINE:
> +		return rproc_inline_coredump(rproc);
> +	default:
> +		break;
> +	}
>  }
>=20
>  #endif /* REMOTEPROC_INTERNAL_H */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad666..23298ce 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -459,6 +459,7 @@ struct rproc_dump_segment {
>   * @dev: virtual device for refcounting and common remoteproc behavior
>   * @power: refcount of users who need this rproc powered up
>   * @state: state of the device
> + * @coredump_conf: Currenlty selected coredump configuration
>   * @lock: lock which protects concurrent manipulations of the rproc
>   * @dbg_dir: debugfs directory of this rproc device
>   * @traces: list of trace buffers
> @@ -492,6 +493,7 @@ struct rproc {
>  	struct device dev;
>  	atomic_t power;
>  	unsigned int state;
> +	unsigned int coredump_conf;
>  	struct mutex lock;
>  	struct dentry *dbg_dir;
>  	struct list_head traces;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> a Linux Foundation Collaborative Project
