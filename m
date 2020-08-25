Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E59C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E20F20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="gfrpN/dF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHYWJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:09:08 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:19638 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgHYWJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:09:05 -0400
X-Greylist: delayed 4140 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2020 18:09:04 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PKwYEF020650;
        Tue, 25 Aug 2020 15:59:59 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00010702.pphosted.com with ESMTP id 332yd20seb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 15:59:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9HnC/nx36CFlsxMutWk7UYvhRoSvw88A1IXHhj1IVWCZ1aqa6D+kAkCBjE3vy3CzXUCemvF9FZycVTIF3oMRbvRLil+bsUKdYMC+wWJe0lPiyZNTqNqaBb604B2yuBZurhqVG9bXHInnvMlOgGox7lPRDOOov4aZOrUE9xEc8bYqPn7mll4h+2LxXdWH9MrhfObDhEyQuUppYHflSFx8S40McPIJEy3+vXuePpebRGFzyX5B9gNEDutfE2RhuYaM3kX5OAZyzlAQcqa+UAcvSdmiBF8vB/UXeS2s769+HNIb+iaVIaeLo4oA0XGi/Jh6UnDsNYh8+sI+fFLiVlj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DVoux9mOwe8Md/r53NawhnBJfYAPMSOH+yfyNG2Ufc=;
 b=jXDApt/NAI1lw5eLAt0r0cZPag4mpRgAbwhBHGaPsyli4IV8UxNHNtDt+s/JHLkYspWswhg6Sj8AJzfUm5Q7+YJwjAV6O9yRDUnao/iUGktr2+2mE94QJObqUy5rIQ+SJpX78RcNiCUhqTlMimH7l9rtuouap6tmPRppk3ilux3zFSHB0a524XVJpAUyGLHZFLJnVFO2rdhJ0EclN84DkLB0dMF2NQs2TzZFk4SHYkKDCzFmKep4EuB6jH4XHtJ+X+OuD6TPUUjR5S37VjNMH9w3b+w7zAPpPY8A/M0Pk33VX3sHCouHCH+uOYz8i4pZVU3J7YBnVNtFuXImIILnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DVoux9mOwe8Md/r53NawhnBJfYAPMSOH+yfyNG2Ufc=;
 b=gfrpN/dFBHOoQIGq91T3k6qlsIM9atycrG4h6drK23iG1qA6EGR3TXpYVsny/NL2BI0WulU7I9l61YE0vTiv2aRG0GK1tnJ19T7G11q4WVq/RVIl3Y2kgLD6REdhbs0c5XCCfV1gdWrWMZgV6q5QDuLvZDx51yq68KS44J0CXqk=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3565.namprd04.prod.outlook.com
 (2603:10b6:803:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 20:59:57 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 20:59:57 +0000
Date:   Tue, 25 Aug 2020 15:59:56 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     stefanos@xilinx.com, michals@xilinx.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wendy.liang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200825205956.GA12885@xaphan>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-4-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811033213.20088-4-ben.levinsky@xilinx.com>
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SA9PR10CA0014.namprd10.prod.outlook.com (2603:10b6:806:a7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 20:59:56 +0000
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0997f714-b531-438b-f095-08d84939d298
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3565:
X-Microsoft-Antispam-PRVS: <SN4PR0401MB35651BF7D0D849E8A8806FDC87570@SN4PR0401MB3565.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sl7ozS4QbgrwZaPDEfYREbgtlpzrU9h1Zv0WFibplSLcUTKCzjqPJc2zFwKfeLPYxSUh3CpMSoCr2QUTqLj+WnYtoYKJnWtL++ufggd197KgNz+4+nD++ZfoCmQUo8mOSiZ+iT3BGlDcs8ha2HmeTte+r+PhnJ994sT8u30scVjo+fDhCZUTf11WX4Wpu2LsSlOHOzWuMa+nCbAVjr36V9F7abYJMgM116PesgreFvgnAD8+piAAecZxJWytHNNAfHDvAoDC7WBNED8JfBAS879+Yh4FjP5/WQNXWlybVtxVjuQRnoqz/DxoELls3j6q3XiFmrnmYWzJPLF6A3GBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(396003)(39840400004)(366004)(346002)(376002)(956004)(33656002)(33716001)(316002)(2906002)(6916009)(1076003)(66946007)(66556008)(8936002)(66476007)(44832011)(5660300002)(478600001)(4326008)(7416002)(16576012)(6486002)(83380400001)(86362001)(52116002)(186003)(8676002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Bum7v3fBl9HkpL0X88qIGS9dGIxn4JK9119bzrBoY0SYqU5Zhs41dSpybLZBPxNMwFs7mZpn/ZfK2qFGb+0OHtN3R83mIMus8QYWFXu5YdCFBIXbVVM0FDSGSNNA7OIOI4NqIuZmBWIuWIW2MdxCfzRe33kE+lCBcB05787yL9cSt6oE481bO5vIDrp0oh7IlM+uyP/quTxRhafIKvJyMr/3iudR7s5lSzjOMYwoeXLZJYGYlYOoiWK/bCLJrx+PPKVxr2mpbvNImD6EpXfJuq2LKR1oh0neAG7uo1/OQ7nxmTpiq+e2OcXYCPk76at2zZCMlIVNoqjOjWCHrAsiklljWMRmxpMIOX6GkMekEv14Q6X3JOHQ8MVun4Ks4TVDQbmHy7SifRjJdIq8X6lXyt72TbK+56LKC+Icqf0dD4PGW22AbxknRYPFzUvUMwlb2tZFxUWJi+53ucw+Cx9m5I7Qvf8fm8JOYMs+DGoJK/5F8D7eZXiyoq+Q43mLQ14FVKt5vdIALoAKbKDOo9fVwyQcEPZFNKX1U1Ry8cn4F5DufHR/mRCTzBUkZyd7hnVDaTjBDpLtf0gFj2csfh+EbQwbCMUjHj0sUIFBYJb1FTHP1y7bGcXd3pAjeIm1Nu5viaWRMWju5oaUgjzAz3aC4SLQny5eqU9wN5XCrJa5uuhoGey4o+EGeiqPuQUB0gUGyIAXRytGZJDcukUP1hiOng==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0997f714-b531-438b-f095-08d84939d298
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 20:59:57.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6J75NgOTOIMTsLuNbd51D3YBCOPoigP9CugVfdpGiUwMGcGTqvn6lQYPhSuTvGSR0lMIv53F6VbnMfbYCSPBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
Subject: Re: [PATCH v8 3/5] firmware: xilinx: Add RPU configuration APIs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_09:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ben,

On Mon, Aug 10, 2020 at 08:32:11PM -0700, Ben Levinsky wrote:
> This patch adds APIs to provide access and a configuration interface
> to the current power state of a sub-system on Zynqmp sub-system.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> v3:
> - add xilinx-related platform mgmt fn's instead of wrapping around
>   function pointer in xilinx eemi ops struct
> v4:
> - add default values for enums
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 99 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 34 ++++++++++
>  2 files changed, 133 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index f1a0bd35deeb..fdd61d258e55 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -846,6 +846,61 @@ int zynqmp_pm_release_node(const u32 node)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>  
> +/**
> + * zynqmp_pm_get_rpu_mode() - Get RPU mode
> + * @node_id:	Node ID of the device
> + * @arg1:	Argument 1 to requested IOCTL call
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value
> + *
> + * Return: RPU mode
> + */
> +int zynqmp_pm_get_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_GET_RPU_OPER_MODE, 0, 0, out);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_rpu_mode() - Set RPU mode
> + * @node_id:	Node ID of the device
> + * @ioctl_id:	ID of the requested IOCTL
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value
> + *
> + * This function is used to set RPU mode.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_SET_RPU_OPER_MODE, 0, 0, out);

This should pass through arg1 instead of 0 for the argument after
IOCTL_SET_RPU_OPER_MODE. As this is, the RPU will always be configured
in lockstep mode regardless of a request to switch to split mode.

Also, the kerneldoc for these functions could use some love (ioctl_id no
longer exists, arg1 isn't documented, arg2 is documented by very
non-specifically).

> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
> +
> +/**
> + * zynqmp_pm_tcm_comb_config - configure TCM
> + * @node_id:	Node ID of the device
> + * @arg1:	Argument 1 to requested IOCTL call
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value
> + *
> + * This function is used to set RPU mode.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_tcm_config(u32 node_id,
> +			     u32 arg1, u32 arg2, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_TCM_COMB_CONFIG, 0, 0, out);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
> +
>  /**
>   * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
>   *             be powered down forcefully
> @@ -881,6 +936,50 @@ int zynqmp_pm_request_wakeup(const u32 node,
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
>  
> +/**
> + * zynqmp_pm_get_node_status - PM call to request a node's current power state
> + * @node:      ID of the component or sub-system in question
> + * @status:        Current operating state of the requested node
> + * @requirements:  Current requirements asserted on the node,
> + *         used for slave nodes only.
> + * @usage:     Usage information, used for slave nodes only:
> + *         PM_USAGE_NO_MASTER  - No master is currently using
> + *                       the node
> + *         PM_USAGE_CURRENT_MASTER - Only requesting master is
> + *                       currently using the node
> + *         PM_USAGE_OTHER_MASTER   - Only other masters are
> + *                       currently using the node
> + *         PM_USAGE_BOTH_MASTERS   - Both the current and at least
> + *                       one other master is currently
> + *                       using the node
> + *
> + * Return: status, either success or error+reason
> + */
> +int zynqmp_pm_get_node_status(const u32 node,
> +			      u32 *status, u32 *requirements,
> +			      u32 *usage)
> +
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!status)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, node, 0, 0, 0,
> +				  ret_payload);
> +	if (ret_payload[0] == XST_PM_SUCCESS) {
> +		*status = ret_payload[1];
> +		if (requirements)
> +			*requirements = ret_payload[2];
> +		if (usage)
> +			*usage = ret_payload[3];
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_node_status);
> +
>  /**
>   * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
>   * @node:		Node ID of the slave
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 4d83a7d69c4c..0caca9e2223a 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -64,6 +64,7 @@
>  
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
> +	PM_GET_NODE_STATUS = 3,
>  	PM_FORCE_POWERDOWN = 8,
>  	PM_REQUEST_WAKEUP = 10,
>  	PM_SYSTEM_SHUTDOWN = 12,
> @@ -384,6 +385,14 @@ int zynqmp_pm_request_wakeup(const u32 node,
>  			     const bool set_addr,
>  			     const u64 address,
>  			     const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_get_node_status(const u32 node, u32 *status,
> +			      u32 *requirements, u32 *usage);
> +int zynqmp_pm_get_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out);
> +int zynqmp_pm_set_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out);
> +int zynqmp_pm_set_tcm_config(u32 node_id,
> +			     u32 arg1, u32 arg2, u32 *out);
>  #else
>  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>  {
> @@ -548,6 +557,31 @@ static inline int zynqmp_pm_request_wakeup(const u32 node,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_get_node_status(const u32 node,
> +					    u32 *status, u32 *requirements,
> +					    u32 *usage)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_get_rpu_mode(u32 node_id,
> +					 u32 arg1, u32 arg2, u32 *out)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_rpu_mode(u32 node_id,
> +					 u32 arg1, u32 arg2, u32 *out)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_tcm_config(u32 node_id,
> +					   u32 arg1, u32 arg2, u32 *out)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> -- 
> 2.17.1
> 

Thanks,
 Michael
