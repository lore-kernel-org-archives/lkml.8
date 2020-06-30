Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8616DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6240920768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgF3HYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:24:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730636AbgF3HYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:24:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U727k4162982;
        Tue, 30 Jun 2020 03:24:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydmr8167-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:24:06 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U72jPN166786;
        Tue, 30 Jun 2020 03:24:06 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydmr815n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:24:06 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U7Ka9U010784;
        Tue, 30 Jun 2020 07:24:04 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 31x5vx3tmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:24:04 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U7O4VT44302720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 07:24:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A42CB2064;
        Tue, 30 Jun 2020 07:24:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99EB8B205F;
        Tue, 30 Jun 2020 07:24:03 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 07:24:03 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 09:24:03 +0200
From:   haver <haver@linux.vnet.ibm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 18/20] misc: genwqe: card_base: Whole host of kerneldoc
 fixes
In-Reply-To: <20200629140442.1043957-19-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-19-lee.jones@linaro.org>
Message-ID: <ecadaa11d1c45974a31efa2c6b25e1ba@linux.vnet.ibm.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=2 mlxscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29 16:04, Lee Jones wrote:
> From missing documentation for function arguments, to promotion
> obvious kerneldoc headers and incorrectly named arguments.
> 
> Fixes the following W=1 warnings:
> 
>  drivers/misc/genwqe/card_base.c:175: warning: Function parameter or
> member 'cd' not described in 'genwqe_bus_reset'
>  drivers/misc/genwqe/card_base.c:272: warning: Function parameter or
> member 'cd' not described in 'genwqe_recovery_on_fatal_gfir_required'
>  drivers/misc/genwqe/card_base.c:293: warning: Function parameter or
> member 'cd' not described in 'genwqe_T_psec'
>  drivers/misc/genwqe/card_base.c:314: warning: Function parameter or
> member 'cd' not described in 'genwqe_setup_pf_jtimer'
>  drivers/misc/genwqe/card_base.c:334: warning: Function parameter or
> member 'cd' not described in 'genwqe_setup_vf_jtimer'
>  drivers/misc/genwqe/card_base.c:557: warning: Function parameter or
> member 'cd' not described in 'genwqe_stop'
>  drivers/misc/genwqe/card_base.c:617: warning: Function parameter or
> member 'cd' not described in 'genwqe_fir_checking'
>  drivers/misc/genwqe/card_base.c:760: warning: Function parameter or
> member 'pci_dev' not described in 'genwqe_pci_fundamental_reset'
>  drivers/misc/genwqe/card_base.c:889: warning: Function parameter or
> member 'data' not described in 'genwqe_health_thread'
>  drivers/misc/genwqe/card_base.c:1046: warning: Function parameter or
> member 'cd' not described in 'genwqe_pci_setup'
>  drivers/misc/genwqe/card_base.c:1131: warning: Function parameter or
> member 'cd' not described in 'genwqe_pci_remove'
>  drivers/misc/genwqe/card_base.c:1151: warning: Function parameter or
> member 'pci_dev' not described in 'genwqe_probe'
>  drivers/misc/genwqe/card_base.c:1151: warning: Function parameter or
> member 'id' not described in 'genwqe_probe'
>  drivers/misc/genwqe/card_base.c:1151: warning: Excess function
> parameter 'pdev' description in 'genwqe_probe'
>  drivers/misc/genwqe/card_base.c:1207: warning: Function parameter or
> member 'pci_dev' not described in 'genwqe_remove'
>  drivers/misc/genwqe/card_base.c:1336: warning: Function parameter or
> member 'dev' not described in 'genwqe_devnode'
>  drivers/misc/genwqe/card_base.c:1336: warning: Function parameter or
> member 'mode' not described in 'genwqe_devnode'
> 
> Cc: Michael Jung <mijung@gmx.net>
> Cc: Michael Ruettger <michael@ibmra.de>
> Cc: Frank Haverkamp <haver@linux.ibm.com>
> Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/genwqe/card_base.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_base.c 
> b/drivers/misc/genwqe/card_base.c
> index 809a6f46f6de3..93d2ed91c85b2 100644
> --- a/drivers/misc/genwqe/card_base.c
> +++ b/drivers/misc/genwqe/card_base.c
> @@ -165,6 +165,7 @@ static void genwqe_dev_free(struct genwqe_dev *cd)
> 
>  /**
>   * genwqe_bus_reset() - Card recovery
> + * @cd: GenWQE device information
>   *
>   * pci_reset_function() will recover the device and ensure that the
>   * registers are accessible again when it completes with success. If
> @@ -262,6 +263,7 @@ static void genwqe_tweak_hardware(struct genwqe_dev 
> *cd)
> 
>  /**
>   * genwqe_recovery_on_fatal_gfir_required() - Version depended actions
> + * @cd: GenWQE device information
>   *
>   * Bitstreams older than 2013-02-17 have a bug where fatal GFIRs must
>   * be ignored. This is e.g. true for the bitstream we gave to the card
> @@ -280,6 +282,7 @@ int genwqe_flash_readback_fails(struct genwqe_dev 
> *cd)
> 
>  /**
>   * genwqe_T_psec() - Calculate PF/VF timeout register content
> + * @cd: GenWQE device information
>   *
>   * Note: From a design perspective it turned out to be a bad idea to
>   * use codes here to specifiy the frequency/speed values. An old
> @@ -303,6 +306,7 @@ static int genwqe_T_psec(struct genwqe_dev *cd)
> 
>  /**
>   * genwqe_setup_pf_jtimer() - Setup PF hardware timeouts for DDCB 
> execution
> + * @cd: GenWQE device information
>   *
>   * Do this _after_ card_reset() is called. Otherwise the values will
>   * vanish. The settings need to be done when the queues are inactive.
> @@ -329,6 +333,7 @@ static bool genwqe_setup_pf_jtimer(struct 
> genwqe_dev *cd)
> 
>  /**
>   * genwqe_setup_vf_jtimer() - Setup VF hardware timeouts for DDCB 
> execution
> + * @cd: GenWQE device information
>   */
>  static bool genwqe_setup_vf_jtimer(struct genwqe_dev *cd)
>  {
> @@ -543,6 +548,7 @@ static int genwqe_start(struct genwqe_dev *cd)
> 
>  /**
>   * genwqe_stop() - Stop card operation
> + * @cd: GenWQE device information
>   *
>   * Recovery notes:
>   *   As long as genwqe_thread runs we might access registers during
> @@ -606,6 +612,7 @@ static int genwqe_health_check_cond(struct
> genwqe_dev *cd, u64 *gfir)
> 
>  /**
>   * genwqe_fir_checking() - Check the fault isolation registers of the 
> card
> + * @cd: GenWQE device information
>   *
>   * If this code works ok, can be tried out with help of the 
> genwqe_poke tool:
>   *   sudo ./tools/genwqe_poke 0x8 0xfefefefefef
> @@ -750,6 +757,7 @@ static u64 genwqe_fir_checking(struct genwqe_dev 
> *cd)
> 
>  /**
>   * genwqe_pci_fundamental_reset() - trigger a PCIe fundamental reset
> on the slot
> + * @pci_dev:	PCI device information struct
>   *
>   * Note: pci_set_pcie_reset_state() is not implemented on all archs, 
> so this
>   * reset method will not work in all cases.
> @@ -814,8 +822,9 @@ static int genwqe_platform_recovery(struct 
> genwqe_dev *cd)
>  	return rc;
>  }
> 
> -/*
> +/**
>   * genwqe_reload_bistream() - reload card bitstream
> + * @cd: GenWQE device information
>   *
>   * Set the appropriate register and call fundamental reset to reaload 
> the card
>   * bitstream.
> @@ -868,6 +877,7 @@ static int genwqe_reload_bistream(struct genwqe_dev 
> *cd)
> 
>  /**
>   * genwqe_health_thread() - Health checking thread
> + * @data: GenWQE device information
>   *
>   * This thread is only started for the PF of the card.
>   *
> @@ -1041,6 +1051,7 @@ static int genwqe_health_check_stop(struct 
> genwqe_dev *cd)
> 
>  /**
>   * genwqe_pci_setup() - Allocate PCIe related resources for our card
> + * @cd: GenWQE device information
>   */
>  static int genwqe_pci_setup(struct genwqe_dev *cd)
>  {
> @@ -1126,6 +1137,7 @@ static int genwqe_pci_setup(struct genwqe_dev 
> *cd)
> 
>  /**
>   * genwqe_pci_remove() - Free PCIe related resources for our card
> + * @cd: GenWQE device information
>   */
>  static void genwqe_pci_remove(struct genwqe_dev *cd)
>  {
> @@ -1140,7 +1152,8 @@ static void genwqe_pci_remove(struct genwqe_dev 
> *cd)
> 
>  /**
>   * genwqe_probe() - Device initialization
> - * @pdev:	PCI device information struct
> + * @pci_dev:	PCI device information struct
> + * @id:		PCI device ID
>   *
>   * Callable for multiple cards. This function is called on bind.
>   *
> @@ -1200,6 +1213,7 @@ static int genwqe_probe(struct pci_dev *pci_dev,
> 
>  /**
>   * genwqe_remove() - Called when device is removed (hot-plugable)
> + * @pci_dev:	PCI device information struct
>   *
>   * Or when driver is unloaded respecitively when unbind is done.
>   */
> @@ -1219,8 +1233,10 @@ static void genwqe_remove(struct pci_dev 
> *pci_dev)
>  	genwqe_dev_free(cd);
>  }
> 
> -/*
> +/**
>   * genwqe_err_error_detected() - Error detection callback
> + * @pci_dev:	PCI device information struct
> + * @state:	PCI channel state
>   *
>   * This callback is called by the PCI subsystem whenever a PCI bus
>   * error is detected.
> @@ -1328,6 +1344,8 @@ static struct pci_driver genwqe_driver = {
> 
>  /**
>   * genwqe_devnode() - Set default access mode for genwqe devices.
> + * @dev:	Pointer to device (unused)
> + * @mode:	Carrier to pass-back given mode (permissions)
>   *
>   * Default mode should be rw for everybody. Do not change default
>   * device name.

Thanks for adding the documentation.

Signed-off-by: Frank Haverkamp <haver@linux.ibm.com>
