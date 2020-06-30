Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E7FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C2320759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgF3H1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:27:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbgF3H1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:27:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U72j69104563;
        Tue, 30 Jun 2020 03:26:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjx9wng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:26:48 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U7DxIC155399;
        Tue, 30 Jun 2020 03:26:47 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjx9wmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:26:47 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U7JwNI031059;
        Tue, 30 Jun 2020 07:26:46 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 31wwr8un9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:26:46 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U7QjUj54067496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 07:26:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D44632805E;
        Tue, 30 Jun 2020 07:26:45 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E78A2805A;
        Tue, 30 Jun 2020 07:26:45 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 07:26:44 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 09:26:44 +0200
From:   haver <haver@linux.vnet.ibm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 20/20] misc: genwqe: card_utils: Whole a plethora of
 documentation issues
In-Reply-To: <20200629140442.1043957-21-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-21-lee.jones@linaro.org>
Message-ID: <670db54cfb390c6bdb5f8a769daa57f7@linux.vnet.ibm.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 cotscore=-2147483648 bulkscore=0
 suspectscore=2 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29 16:04, Lee Jones wrote:
> Including; demoting file header from kerneldoc to standard comment/
> header, adding a variety of missing function argument documentation,
> repairing formatting (kerneldoc does not like blank lines) and the
> demotion of a kerneldoc header which shows no interest in providing
> documentation for any of its arguments.
> 
> Fixes this the following W=1 issues:
> 
>  drivers/misc/genwqe/card_utils.c:37: warning: Incorrect use of
> kernel-doc format:  * __genwqe_writeq() - Write 64-bit register
>  drivers/misc/genwqe/card_utils.c:45: warning: Function parameter or
> member 'cd' not described in '__genwqe_writeq'
>  drivers/misc/genwqe/card_utils.c:45: warning: Function parameter or
> member 'byte_offs' not described in '__genwqe_writeq'
>  drivers/misc/genwqe/card_utils.c:45: warning: Function parameter or
> member 'val' not described in '__genwqe_writeq'
>  drivers/misc/genwqe/card_utils.c:136: warning: Function parameter or
> member 'cd' not described in 'genwqe_read_app_id'
>  drivers/misc/genwqe/card_utils.c:136: warning: Function parameter or
> member 'app_name' not described in 'genwqe_read_app_id'
>  drivers/misc/genwqe/card_utils.c:136: warning: Function parameter or
> member 'len' not described in 'genwqe_read_app_id'
>  drivers/misc/genwqe/card_utils.c:186: warning: bad line:
>  drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or
> member 'cd' not described in 'genwqe_alloc_sync_sgl'
>  drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or
> member 'sgl' not described in 'genwqe_alloc_sync_sgl'
>  drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or
> member 'user_addr' not described in 'genwqe_alloc_sync_sgl'
>  drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or
> member 'user_size' not described in 'genwqe_alloc_sync_sgl'
>  drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or
> member 'write' not described in 'genwqe_alloc_sync_sgl'
>  drivers/misc/genwqe/card_utils.c:469: warning: Function parameter or
> member 'cd' not described in 'genwqe_free_sync_sgl'
>  drivers/misc/genwqe/card_utils.c:469: warning: Function parameter or
> member 'sgl' not described in 'genwqe_free_sync_sgl'
>  drivers/misc/genwqe/card_utils.c:716: warning: Function parameter or
> member 'count' not described in 'genwqe_set_interrupt_capability'
>  drivers/misc/genwqe/card_utils.c:747: warning: Function parameter or
> member 'idx' not described in 'set_reg_idx'
>  drivers/misc/genwqe/card_utils.c:747: warning: Excess function
> parameter 'index' description in 'set_reg_idx'
>  drivers/misc/genwqe/card_utils.c:823: warning: Function parameter or
> member 'cd' not described in 'genwqe_ffdc_buff_size'
>  drivers/misc/genwqe/card_utils.c:823: warning: Function parameter or
> member 'uid' not described in 'genwqe_ffdc_buff_size'
>  drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or
> member 'cd' not described in 'genwqe_ffdc_buff_read'
>  drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or
> member 'uid' not described in 'genwqe_ffdc_buff_read'
>  drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or
> member 'regs' not described in 'genwqe_ffdc_buff_read'
>  drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or
> member 'max_regs' not described in 'genwqe_ffdc_buff_read'
>  drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or
> member 'cd' not described in 'genwqe_write_vreg'
>  drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or
> member 'reg' not described in 'genwqe_write_vreg'
>  drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or
> member 'val' not described in 'genwqe_write_vreg'
>  drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or
> member 'func' not described in 'genwqe_write_vreg'
>  drivers/misc/genwqe/card_utils.c:977: warning: Function parameter or
> member 'cd' not described in 'genwqe_read_vreg'
>  drivers/misc/genwqe/card_utils.c:977: warning: Function parameter or
> member 'reg' not described in 'genwqe_read_vreg'
>  drivers/misc/genwqe/card_utils.c:977: warning: Function parameter or
> member 'func' not described in 'genwqe_read_vreg'
>  drivers/misc/genwqe/card_utils.c:995: warning: Function parameter or
> member 'cd' not described in 'genwqe_base_clock_frequency'
>  drivers/misc/genwqe/card_utils.c:1012: warning: Function parameter or
> member 'cd' not described in 'genwqe_stop_traps'
>  drivers/misc/genwqe/card_utils.c:1022: warning: Function parameter or
> member 'cd' not described in 'genwqe_start_traps'
> 
> Cc: Michael Jung <mijung@gmx.net>
> Cc: Michael Ruettger <michael@ibmra.de>
> Cc: Frank Haverkamp <haver@linux.ibm.com>
> Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
>  # Please enter the commit message for your changes. Lines starting
>  # with '#' will be ignored, and an empty message aborts the commit.
>  #
>  # Date:      Mon Jun 29 10:30:56 2020 +0100
>  #
>  # On branch tb-mfd-fix-warnings
>  # Changes to be committed:
>  #	modified:   drivers/misc/genwqe/card_utils.c
>  #
>  # Untracked files:
>  #	qemu-i2c-devs.txt
>  #
> ---
>  drivers/misc/genwqe/card_utils.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_utils.c 
> b/drivers/misc/genwqe/card_utils.c
> index 77c21caf2acd1..039b923d1d60a 100644
> --- a/drivers/misc/genwqe/card_utils.c
> +++ b/drivers/misc/genwqe/card_utils.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * IBM Accelerator Family 'GenWQE'
>   *
>   * (C) Copyright IBM Corp. 2013
> @@ -129,6 +129,9 @@ u32 __genwqe_readl(struct genwqe_dev *cd, u64 
> byte_offs)
> 
>  /**
>   * genwqe_read_app_id() - Extract app_id
> + * @cd:	        genwqe device descriptor
> + * @app_name:   carrier used to pass-back name
> + * @len:        length of data for name
>   *
>   * app_unitcfg need to be filled with valid data first
>   */
> @@ -183,7 +186,7 @@ void genwqe_init_crc32(void)
>   * @init:       initial crc (0xffffffff at start)
>   *
>   * polynomial = x^32 * + x^29 + x^18 + x^14 + x^3 + 1 (0x20044009)
> -
> + *
>   * Example: 4 bytes 0x01 0x02 0x03 0x04 with init=0xffffffff should
>   * result in a crc32 of 0xf33cb7d3.
>   *
> @@ -277,7 +280,7 @@ static int genwqe_sgl_size(int num_pages)
>  	return roundup(len, PAGE_SIZE);
>  }
> 
> -/**
> +/*
>   * genwqe_alloc_sync_sgl() - Allocate memory for sgl and overlapping 
> pages
>   *
>   * Allocates memory for sgl and overlapping pages. Pages which might
> @@ -460,6 +463,8 @@ int genwqe_setup_sgl(struct genwqe_dev *cd, struct
> genwqe_sgl *sgl,
> 
>  /**
>   * genwqe_free_sync_sgl() - Free memory for sgl and overlapping pages
> + * @cd:	        genwqe device descriptor
> + * @sgl:        scatter gather list describing user-space memory
>   *
>   * After the DMA transfer has been completed we free the memory for
>   * the sgl and the cached pages. Data is being transferred from cached
> @@ -710,6 +715,7 @@ int genwqe_read_softreset(struct genwqe_dev *cd)
>  /**
>   * genwqe_set_interrupt_capability() - Configure MSI capability 
> structure
>   * @cd:         pointer to the device
> + * @count:      number of vectors to allocate
>   * Return: 0 if no error
>   */
>  int genwqe_set_interrupt_capability(struct genwqe_dev *cd, int count)
> @@ -738,7 +744,7 @@ void genwqe_reset_interrupt_capability(struct
> genwqe_dev *cd)
>   * @i:          index to desired entry
>   * @m:          maximum possible entries
>   * @addr:       addr which is read
> - * @index:      index in debug array
> + * @idx:        index in debug array
>   * @val:        read value
>   */
>  static int set_reg_idx(struct genwqe_dev *cd, struct genwqe_reg *r,
> @@ -818,6 +824,8 @@ int genwqe_read_ffdc_regs(struct genwqe_dev *cd,
> struct genwqe_reg *regs,
> 
>  /**
>   * genwqe_ffdc_buff_size() - Calculates the number of dump registers
> + * @cd:	        genwqe device descriptor
> + * @uid:	unit ID
>   */
>  int genwqe_ffdc_buff_size(struct genwqe_dev *cd, int uid)
>  {
> @@ -871,6 +879,10 @@ int genwqe_ffdc_buff_size(struct genwqe_dev *cd, 
> int uid)
> 
>  /**
>   * genwqe_ffdc_buff_read() - Implements LogoutExtendedErrorRegisters 
> procedure
> + * @cd:	        genwqe device descriptor
> + * @uid:	unit ID
> + * @regs:       register information
> + * @max_regs:   number of register entries
>   */
>  int genwqe_ffdc_buff_read(struct genwqe_dev *cd, int uid,
>  			  struct genwqe_reg *regs, unsigned int max_regs)
> @@ -956,6 +968,10 @@ int genwqe_ffdc_buff_read(struct genwqe_dev *cd, 
> int uid,
> 
>  /**
>   * genwqe_write_vreg() - Write register in virtual window
> + * @cd:	        genwqe device descriptor
> + * @reg:	register (byte) offset within BAR
> + * @val:	value to write
> + * @func:	PCI virtual function
>   *
>   * Note, these registers are only accessible to the PF through the
>   * VF-window. It is not intended for the VF to access.
> @@ -969,6 +985,9 @@ int genwqe_write_vreg(struct genwqe_dev *cd, u32
> reg, u64 val, int func)
> 
>  /**
>   * genwqe_read_vreg() - Read register in virtual window
> + * @cd:	        genwqe device descriptor
> + * @reg:	register (byte) offset within BAR
> + * @func:	PCI virtual function
>   *
>   * Note, these registers are only accessible to the PF through the
>   * VF-window. It is not intended for the VF to access.
> @@ -981,6 +1000,7 @@ u64 genwqe_read_vreg(struct genwqe_dev *cd, u32
> reg, int func)
> 
>  /**
>   * genwqe_base_clock_frequency() - Deteremine base clock frequency of 
> the card
> + * @cd:	        genwqe device descriptor
>   *
>   * Note: From a design perspective it turned out to be a bad idea to
>   * use codes here to specifiy the frequency/speed values. An old
> @@ -1005,6 +1025,7 @@ int genwqe_base_clock_frequency(struct genwqe_dev 
> *cd)
> 
>  /**
>   * genwqe_stop_traps() - Stop traps
> + * @cd:	        genwqe device descriptor
>   *
>   * Before reading out the analysis data, we need to stop the traps.
>   */
> @@ -1015,6 +1036,7 @@ void genwqe_stop_traps(struct genwqe_dev *cd)
> 
>  /**
>   * genwqe_start_traps() - Start traps
> + * @cd:	        genwqe device descriptor
>   *
>   * After having read the data, we can/must enable the traps again.
>   */

Thanks for adding proper documentation to our driver.

Signed-off-by: Frank Haverkamp <haver@linux.ibm.com>
