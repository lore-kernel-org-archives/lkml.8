Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D06C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC3720759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgF3HZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:25:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbgF3HZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:25:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U73Ron112395;
        Tue, 30 Jun 2020 03:25:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31y3xd6gky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:25:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U74LfH117394;
        Tue, 30 Jun 2020 03:25:46 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31y3xd6gkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:25:46 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U7GKlH031827;
        Tue, 30 Jun 2020 07:25:45 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 31wwr8knfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:25:45 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U7Pg7010486354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 07:25:42 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF9813605D;
        Tue, 30 Jun 2020 07:25:43 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AE9113604F;
        Tue, 30 Jun 2020 07:25:43 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 07:25:43 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 09:25:43 +0200
From:   haver <haver@linux.vnet.ibm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 19/20] misc: genwqe: card_dev: Whole host of kerneldoc
 fixes
In-Reply-To: <20200629140442.1043957-20-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-20-lee.jones@linaro.org>
Message-ID: <ee07c5e22bd8c42afdce7a59e93d8fcf@linux.vnet.ibm.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=2
 cotscore=-2147483648 clxscore=1015 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29 16:04, Lee Jones wrote:
> Including; add missing documentation for function arguments, 
> re-ordering
> of #defines i.e. not placed between kerneldoc headers and the functions
> they are documenting, demotion of file header/comment from kerneldoc
> format and removal of documentation for non-existent args.
> 
> Fixes the following W=1 kernel build warnings:
> 
>  drivers/misc/genwqe/card_dev.c:33: warning: Function parameter or
> member 'cd' not described in 'genwqe_open_files'
>  drivers/misc/genwqe/card_dev.c:98: warning: Function parameter or
> member 'virt_addr' not described in 'genwqe_search_pin'
>  drivers/misc/genwqe/card_dev.c:98: warning: Excess function parameter
> 'dma_addr' description in 'genwqe_search_pin'
>  drivers/misc/genwqe/card_dev.c:154: warning: Function parameter or
> member 'virt_addr' not described in '__genwqe_search_mapping'
>  drivers/misc/genwqe/card_dev.c:256: warning: Function parameter or
> member 'cd' not described in 'genwqe_kill_fasync'
>  drivers/misc/genwqe/card_dev.c:256: warning: Function parameter or
> member 'sig' not described in 'genwqe_kill_fasync'
>  drivers/misc/genwqe/card_dev.c:387: warning: Function parameter or
> member 'vma' not described in 'genwqe_vma_close'
>  drivers/misc/genwqe/card_dev.c:430: warning: Function parameter or
> member 'filp' not described in 'genwqe_mmap'
>  drivers/misc/genwqe/card_dev.c:430: warning: Function parameter or
> member 'vma' not described in 'genwqe_mmap'
>  drivers/misc/genwqe/card_dev.c:495: warning: Excess function
> parameter 'cd' description in 'FLASH_BLOCK'
>  drivers/misc/genwqe/card_dev.c:495: warning: Excess function
> parameter 'load' description in 'FLASH_BLOCK'
>  drivers/misc/genwqe/card_dev.c:827: warning: Function parameter or
> member 'cfile' not described in 'ddcb_cmd_cleanup'
>  drivers/misc/genwqe/card_dev.c:827: warning: Function parameter or
> member 'req' not described in 'ddcb_cmd_cleanup'
>  drivers/misc/genwqe/card_dev.c:854: warning: Function parameter or
> member 'cfile' not described in 'ddcb_cmd_fixups'
>  drivers/misc/genwqe/card_dev.c:854: warning: Function parameter or
> member 'req' not described in 'ddcb_cmd_fixups'
>  drivers/misc/genwqe/card_dev.c:984: warning: Function parameter or
> member 'cfile' not described in 'genwqe_execute_ddcb'
>  drivers/misc/genwqe/card_dev.c:984: warning: Function parameter or
> member 'cmd' not described in 'genwqe_execute_ddcb'
>  drivers/misc/genwqe/card_dev.c:1350: warning: Function parameter or
> member 'cd' not described in 'genwqe_device_remove'
> 
> Cc: Michael Jung <mijung@gmx.net>
> Cc: Michael Ruettger <michael@ibmra.de>
> Cc: Frank Haverkamp <haver@linux.ibm.com>
> Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/genwqe/card_dev.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_dev.c 
> b/drivers/misc/genwqe/card_dev.c
> index 040a0bda31254..55fc5b80e649f 100644
> --- a/drivers/misc/genwqe/card_dev.c
> +++ b/drivers/misc/genwqe/card_dev.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * IBM Accelerator Family 'GenWQE'
>   *
>   * (C) Copyright IBM Corp. 2013
> @@ -87,7 +87,7 @@ static int genwqe_del_pin(struct genwqe_file *cfile,
> struct dma_mapping *m)
>   * @cfile:	Descriptor of opened file
>   * @u_addr:	User virtual address
>   * @size:	Size of buffer
> - * @dma_addr:	DMA address to be updated
> + * @virt_addr:	Virtual address to be updated
>   *
>   * Return: Pointer to the corresponding mapping	NULL if not found
>   */
> @@ -144,6 +144,7 @@ static void __genwqe_del_mapping(struct genwqe_file 
> *cfile,
>   * @u_addr:	user virtual address
>   * @size:	size of buffer
>   * @dma_addr:	DMA address to be updated
> + * @virt_addr:	Virtual address to be updated
>   * Return: Pointer to the corresponding mapping	NULL if not found
>   */
>  static struct dma_mapping *__genwqe_search_mapping(struct genwqe_file 
> *cfile,
> @@ -249,6 +250,8 @@ static void genwqe_remove_pinnings(struct
> genwqe_file *cfile)
> 
>  /**
>   * genwqe_kill_fasync() - Send signal to all processes with open 
> GenWQE files
> + * @cd: GenWQE device information
> + * @sig: Signal to send out
>   *
>   * E.g. genwqe_send_signal(cd, SIGIO);
>   */
> @@ -380,6 +383,7 @@ static void genwqe_vma_open(struct vm_area_struct 
> *vma)
> 
>  /**
>   * genwqe_vma_close() - Called each time when vma is unmapped
> + * @vma: VMA area to close
>   *
>   * Free memory which got allocated by GenWQE mmap().
>   */
> @@ -416,6 +420,8 @@ static const struct vm_operations_struct 
> genwqe_vma_ops = {
> 
>  /**
>   * genwqe_mmap() - Provide contignous buffers to userspace
> + * @filp:	File pointer (unused)
> + * @vma:	VMA area to map
>   *
>   * We use mmap() to allocate contignous buffers used for DMA
>   * transfers. After the buffer is allocated we remap it to user-space
> @@ -484,16 +490,15 @@ static int genwqe_mmap(struct file *filp, struct
> vm_area_struct *vma)
>  	return rc;
>  }
> 
> +#define	FLASH_BLOCK	0x40000	/* we use 256k blocks */
> +
>  /**
>   * do_flash_update() - Excute flash update (write image or CVPD)
> - * @cd:        genwqe device
> + * @cfile:	Descriptor of opened file
>   * @load:      details about image load
>   *
>   * Return: 0 if successful
>   */
> -
> -#define	FLASH_BLOCK	0x40000	/* we use 256k blocks */
> -
>  static int do_flash_update(struct genwqe_file *cfile,
>  			   struct genwqe_bitstream *load)
>  {
> @@ -820,6 +825,8 @@ static int genwqe_unpin_mem(struct genwqe_file
> *cfile, struct genwqe_mem *m)
> 
>  /**
>   * ddcb_cmd_cleanup() - Remove dynamically created fixup entries
> + * @cfile:	Descriptor of opened file
> + * @req:	DDCB work request
>   *
>   * Only if there are any. Pinnings are not removed.
>   */
> @@ -844,6 +851,8 @@ static int ddcb_cmd_cleanup(struct genwqe_file
> *cfile, struct ddcb_requ *req)
> 
>  /**
>   * ddcb_cmd_fixups() - Establish DMA fixups/sglists for user memory 
> references
> + * @cfile:	Descriptor of opened file
> + * @req:	DDCB work request
>   *
>   * Before the DDCB gets executed we need to handle the fixups. We
>   * replace the user-space addresses with DMA addresses or do
> @@ -974,6 +983,8 @@ static int ddcb_cmd_fixups(struct genwqe_file
> *cfile, struct ddcb_requ *req)
> 
>  /**
>   * genwqe_execute_ddcb() - Execute DDCB using userspace address fixups
> + * @cfile:	Descriptor of opened file
> + * @cmd:        Command identifier (passed from user)
>   *
>   * The code will build up the translation tables or lookup the
>   * contignous memory allocation table to find the right translations
> @@ -1339,6 +1350,7 @@ static int
> genwqe_inform_and_stop_processes(struct genwqe_dev *cd)
> 
>  /**
>   * genwqe_device_remove() - Remove genwqe's char device
> + * @cd: GenWQE device information
>   *
>   * This function must be called after the client devices are removed
>   * because it will free the major/minor number range for the genwqe


Ok.

Signed-off-by: Frank Haverkamp <haver@linux.ibm.com>
