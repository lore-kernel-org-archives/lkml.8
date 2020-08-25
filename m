Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C338C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A40206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="C6LlAcX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHYVjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:39:54 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:57856 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgHYVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:39:52 -0400
X-Greylist: delayed 1806 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2020 17:39:50 EDT
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PL79kh006685;
        Tue, 25 Aug 2020 16:09:39 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-00010702.pphosted.com with ESMTP id 333166yhp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 16:09:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFhLNyS9Tg7hv9BBiQVpukr+XaKDJaquZBy7t6Z8ukyYr88Xa29U3hroJoZpCytPiSB1v9cXJOJTqkx9CEyTkcGxHghPmZTi0ZnVaClBc/POyUXEbzZAw8vRZwyvUhFLztlqcAIBQEw2tJlWuSBOQB8hi7AswEzOQOuBKKWuHbrvOlKnl6jvYpkGKmJnLDKpu6TbDzvouFb4cGjEShWzBim+aapWqJ+dCONVo9jWPFd9F5GG9BXvH9l3MO8gkqJOtXyF3ioEpC0DcQsQ2w9orE9B9EAhW0BSrCxu5vd01fuJShe3mo5mjAYc/jU+KXksR+d1jpKLKvcR75UmxS6hMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmZAccUctEqugXqsGGU2T5DJnaPHLO/zg1n2FSM2054=;
 b=PJDwwGWYlzBA4Q8xPWJ2f+BkHB2xhtIeeeIPgaMac66L7qJd4yFKifcOf4w9PLyP17L8LMyd2NPcS6gLGUBpB1dPuaCPOSw9xsI9U8dI7LV7jkOE2QXX176oex8ZCE11Xi10Db7M2BFzkA9DUq0qX/3QaZ/yLJYK8Q8nPpaSmThKZflztbb2+IGwtFTifQBrB1oQL0ZLJ53js5r4TIyka9PI9fWxi80y6YBj4jNZ+DNipm1l2gnE8J/ymD8TMnUnUOWkkrzTPw0bVNyvAD2oSTi3kKEiO5DmvMjTejPxCcg9ykQN0fZC189ZVWqwx2nzWr7e+gN59T6gj6T7jaIsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmZAccUctEqugXqsGGU2T5DJnaPHLO/zg1n2FSM2054=;
 b=C6LlAcX1f9V1Blwra/uLH6D5m9VZkTiT9RLacNL2wxX/rwkESRhSSHcUksa5Jjsnjj8sMUbyp2ZREI35XF3tqhyCNlCNQGMBKEGeRgaIt4XM3JBhj3M+whXxCQm3ioXawJDY3VJ5rGu2R++jekygMvgYe+h5FDq+x2aLX3pp8DA=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3565.namprd04.prod.outlook.com
 (2603:10b6:803:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 21:09:32 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 21:09:32 +0000
Date:   Tue, 25 Aug 2020 16:09:31 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     stefanos@xilinx.com, michals@xilinx.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wendy.liang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jason Wu <j.wu@xilinx.com>
Message-ID: <20200825210931.GB12885@xaphan>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-6-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811033213.20088-6-ben.levinsky@xilinx.com>
X-ClientProxiedBy: DM5PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:4:60::22) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM5PR08CA0033.namprd08.prod.outlook.com (2603:10b6:4:60::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 21:09:32 +0000
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2752d5e4-a561-4543-b09f-08d8493b29aa
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3565:
X-Microsoft-Antispam-PRVS: <SN4PR0401MB35659CB7D50F26DCAF07304E87570@SN4PR0401MB3565.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EjlVK747XgdkMGrXP0DTHSfET4fr/v6Rq7CZ2NNSb3bGlC5JhbeOH8QnfGd7dgRgnDWDQEA1FwCdxq0shBneWZ7mf+hvIeT36N+HX6BhzLNAsgEdASkDJ9EYGQkjyMxprsOAPq+qDtcNblHkUKt/voHeNFt6KTu9o9uMXwyP6wP//cC7Aelj/xSuDYDA4yRZkG/hUu/LukTPvWB2WuJPkcN/dJpIsEVpWjnXELCHFRIt+LxaAvXp3H/X0x5KbAvth47OpHRfL/9k78zpuiePTlDp5dCQXYQ1YtcngJQzzEnB9VI4GmsSg7ubZ7Tbi1Y1LvjX7uivoLZ+3/2olEb+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(396003)(39840400004)(366004)(346002)(376002)(956004)(33656002)(33716001)(316002)(2906002)(6916009)(1076003)(66946007)(66556008)(8936002)(66476007)(44832011)(5660300002)(478600001)(4326008)(7416002)(16576012)(6486002)(83380400001)(86362001)(54906003)(52116002)(186003)(30864003)(8676002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: A1OaFoOWUuOdpl9Qt5eq77sNWIM0KpYGfvVZx5xdg23flgkz/GTZP/pZPe50y6qf8iNg4RSrBEnRzN5W1QWn8Dtv6JSisETYFkKY3Sge+khHEbi/fHVUycWMw12wtJ0Mi40HFPWgIxKXWaaMUv1k0zWBTPeItYXsPTISNpViO9QVtBIQ3VhXxxMllerGXirJxQtcaZh+sA8f58HX0lMZcHwqFsdqfnztZz/NnMI64vWW1cQcs4MS7/31Tig9gcGxzqOpyURnILeCw9UoUABESl6xMub7nK20KWZicmGnMxG/+wt8tT/ZxqcJvG/FstQVwRAStERCArpGVORUN3ARb9sSu166TatC4OgMlZfbfL6UjZ/8W6ySYnl69xLX3ojyw0yfRMqOriSdu2PELx4xw/d2PZF/ykIpRK+jYyHeLm+BAqBNWInRUo0axq9BR3L+5tfxjd/AlzJeg5LpvBhCk7YfoIrvmvZ1Xwz52Q8r9tfmSsewmOZT/EhRXjUYv8jUL60IkrQTzhe2HkNzNbSlAQL5SNZAI/rhF8tfZrKLdTYpxs1CZSe7WF1robpsjrbW3SU6lWv5U9WqD05q6yIPdUtEaUGhV/jRSCgS/wtocOMwgQu5BVlfCw/wylVHLx2dWxd2do6wToAsJwcY/R8FZ7n6YeywzO33sH2EYtaPdsPn0khzAI3lzT+oUW8Eq/AELnXKJhVKxGA8wTc7SDH8UQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2752d5e4-a561-4543-b09f-08d8493b29aa
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 21:09:32.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFuy3dUlgVAg8f+7CrWbCYJHM0B+Sye8AUjOeYuJNjsz/Uj3GpQQsj9AtJAb27RZxVvTlsS9QiH5FM8rXy5gTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
Subject: Re: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_09:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=5
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ben,

On Mon, Aug 10, 2020 at 08:32:13PM -0700, Ben Levinsky wrote:
> +/**
> + * zynqmp_r5_release() - ZynqMP R5 device release function
> + * @dev: pointer to the device struct of ZynqMP R5
> + *
> + * Function to release ZynqMP R5 device.
> + */
> +static void zynqmp_r5_release(struct device *dev)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +	struct rproc *rproc;
> +	struct sk_buff *skb;
> +
> +	pdata = dev_get_drvdata(dev);
> +	rproc = pdata->rproc;
> +	if (rproc) {
> +		rproc_del(rproc);
> +		rproc_free(rproc);
> +	}
> +	if (pdata->tx_chan)
> +		mbox_free_channel(pdata->tx_chan);
> +	if (pdata->rx_chan)
> +		mbox_free_channel(pdata->rx_chan);
> +	/* Discard all SKBs */
> +	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> +		skb = skb_dequeue(&pdata->tx_mc_skbs);
> +		kfree_skb(skb);

In the event that zynqmp_r5_probe() fails before zynqmp_r5_setup_mbox()
has run, this will be called on an uninitialized skb_queue. (Also
obviously an issue once mailboxes are made optional again).

> +	}
> +
> +	put_device(dev->parent);
> +}
> +
> +/**
> + * event_notified_idr_cb() - event notified idr callback
> + * @id: idr id
> + * @ptr: pointer to idr private data
> + * @data: data passed to idr_for_each callback
> + *
> + * Pass notification to remoteproc virtio
> + *
> + * Return: 0. having return is to satisfy the idr_for_each() function
> + *          pointer input argument requirement.
> + **/
> +static int event_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	(void)rproc_vq_interrupt(rproc, id);
> +	return 0;
> +}
> +
> +/**
> + * handle_event_notified() - remoteproc notification work funciton
> + * @work: pointer to the work structure
> + *
> + * It checks each registered remoteproc notify IDs.
> + */
> +static void handle_event_notified(struct work_struct *work)
> +{
> +	struct rproc *rproc;
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = container_of(work, struct zynqmp_r5_pdata, mbox_work);
> +
> +	(void)mbox_send_message(pdata->rx_chan, NULL);
> +	rproc = pdata->rproc;
> +	/*
> +	 * We only use IPI for interrupt. The firmware side may or may
> +	 * not write the notifyid when it trigger IPI.
> +	 * And thus, we scan through all the registered notifyids.
> +	 */
> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> +}
> +
> +/**
> + * zynqmp_r5_mb_rx_cb() - Receive channel mailbox callback
> + * @cl: mailbox client
> + * @mssg: message pointer
> + *
> + * It will schedule the R5 notification work.
> + */
> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *mssg)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = container_of(cl, struct zynqmp_r5_pdata, rx_mc);
> +	if (mssg) {
> +		struct zynqmp_ipi_message *ipi_msg, *buf_msg;
> +		size_t len;
> +
> +		ipi_msg = (struct zynqmp_ipi_message *)mssg;
> +		buf_msg = (struct zynqmp_ipi_message *)pdata->rx_mc_buf;
> +		len = (ipi_msg->len >= IPI_BUF_LEN_MAX) ?
> +		      IPI_BUF_LEN_MAX : ipi_msg->len;
> +		buf_msg->len = len;
> +		memcpy(buf_msg->data, ipi_msg->data, len);
> +	}
> +	schedule_work(&pdata->mbox_work);
> +}
> +
> +/**
> + * zynqmp_r5_mb_tx_done() - Request has been sent to the remote
> + * @cl: mailbox client
> + * @mssg: pointer to the message which has been sent
> + * @r: status of last TX - OK or error
> + *
> + * It will be called by the mailbox framework when the last TX has done.
> + */
> +static void zynqmp_r5_mb_tx_done(struct mbox_client *cl, void *mssg, int r)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +	struct sk_buff *skb;
> +
> +	if (!mssg)
> +		return;
> +	pdata = container_of(cl, struct zynqmp_r5_pdata, tx_mc);
> +	skb = skb_dequeue(&pdata->tx_mc_skbs);
> +	kfree_skb(skb);
> +}
> +
> +/**
> + * zynqmp_r5_setup_mbox() - Setup mailboxes
> + *
> + * @pdata: pointer to the ZynqMP R5 processor platform data
> + * @node: pointer of the device node
> + *
> + * Function to setup mailboxes to talk to RPU.
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_setup_mbox(struct zynqmp_r5_pdata *pdata,
> +				struct device_node *node)
> +{
> +	struct device *dev = &pdata->dev;
> +	struct mbox_client *mclient;
> +
> +	/* Setup TX mailbox channel client */
> +	mclient = &pdata->tx_mc;
> +	mclient->dev = dev;
> +	mclient->rx_callback = NULL;
> +	mclient->tx_block = false;
> +	mclient->knows_txdone = false;
> +	mclient->tx_done = zynqmp_r5_mb_tx_done;
> +
> +	/* Setup TX mailbox channel client */
> +	mclient = &pdata->rx_mc;
> +	mclient->dev = dev;
> +	mclient->rx_callback = zynqmp_r5_mb_rx_cb;
> +	mclient->tx_block = false;
> +	mclient->knows_txdone = false;
> +
> +	INIT_WORK(&pdata->mbox_work, handle_event_notified);
> +
> +	/* Request TX and RX channels */
> +	pdata->tx_chan = mbox_request_channel_byname(&pdata->tx_mc, "tx");
> +	if (IS_ERR(pdata->tx_chan)) {
> +		dev_err(dev, "failed to request mbox tx channel.\n");
> +		pdata->tx_chan = NULL;
> +		return -EINVAL;
> +	}
> +	pdata->rx_chan = mbox_request_channel_byname(&pdata->rx_mc, "rx");
> +	if (IS_ERR(pdata->rx_chan)) {
> +		dev_err(dev, "failed to request mbox rx channel.\n");
> +		pdata->rx_chan = NULL;
> +		return -EINVAL;
> +	}
> +	skb_queue_head_init(&pdata->tx_mc_skbs);
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_r5_probe() - Probes ZynqMP R5 processor device node
> + * @pdata: pointer to the ZynqMP R5 processor platform data
> + * @pdev: parent RPU domain platform device
> + * @node: pointer of the device node
> + *
> + * Function to retrieve the information of the ZynqMP R5 device node.
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_probe(struct zynqmp_r5_pdata *pdata,
> +			   struct platform_device *pdev,
> +			   struct device_node *node)
> +{
> +	struct device *dev = &pdata->dev;
> +	struct rproc *rproc;
> +	struct device_node *nc;
> +	int ret;
> +
> +	/* Create device for ZynqMP R5 device */
> +	dev->parent = &pdev->dev;
> +	dev->release = zynqmp_r5_release;
> +	dev->of_node = node;
> +	dev_set_name(dev, "%s", of_node_full_name(node));
> +	dev_set_drvdata(dev, pdata);
> +	ret = device_register(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register device.\n");
> +		return ret;
> +	}
> +	get_device(&pdev->dev);
> +
> +	/* Allocate remoteproc instance */
> +	rproc = rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops, NULL, 0);
> +	if (!rproc) {
> +		dev_err(dev, "rproc allocation failed.\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +	rproc->auto_boot = autoboot;
> +	pdata->rproc = rproc;
> +	rproc->priv = pdata;
> +
> +	/*
> +	 * The device has not been spawned from a device tree, so
> +	 * arch_setup_dma_ops has not been called, thus leaving
> +	 * the device with dummy DMA ops.
> +	 * Fix this by inheriting the parent's DMA ops and mask.
> +	 */
> +	rproc->dev.dma_mask = pdev->dev.dma_mask;
> +	set_dma_ops(&rproc->dev, get_dma_ops(&pdev->dev));
> +
> +	/* Probe R5 memory devices */
> +	INIT_LIST_HEAD(&pdata->mems);
> +	for_each_available_child_of_node(node, nc) {
> +		ret = zynqmp_r5_mem_probe(pdata, nc);
> +		if (ret) {
> +			dev_err(dev, "failed to probe memory %s.\n",
> +				of_node_full_name(nc));
> +			goto error;
> +		}
> +	}
> +
> +	/* Set up DMA mask */
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_warn(dev, "dma_set_coherent_mask failed: %d\n", ret);
> +		/* If DMA is not configured yet, try to configure it. */
> +		ret = of_dma_configure(dev, node, true);
> +		if (ret) {
> +			dev_err(dev, "failed to configure DMA.\n");
> +			goto error;
> +		}
> +	}
> +
> +	/* Get R5 power domain node */
> +	ret = of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> +	if (ret) {
> +		dev_err(dev, "failed to get power node id.\n");
> +		goto error;
> +	}
> +
> +	/* TODO Check if R5 is running */
> +
> +	/* Set up R5 if not already setup */
> +	ret = pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
> +	if (ret) {
> +		dev_err(dev, "failed to set R5 operation mode.\n");
> +		return ret;
> +	}
> +
> +	if (!of_get_property(dev->of_node, "mboxes", NULL)) {
> +		dev_dbg(dev, "no mailboxes.\n");
> +		goto error;
> +	} else {
> +		ret = zynqmp_r5_setup_mbox(pdata, node);
> +		if (ret < 0)
> +			goto error;
> +	}
> +
> +	/* Add R5 remoteproc */
> +	ret = rproc_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "rproc registration failed\n");
> +		goto error;
> +	}
> +	return 0;
> +error:
> +	if (pdata->rproc)
> +		rproc_free(pdata->rproc);
> +	pdata->rproc = NULL;
> +	device_unregister(dev);
> +	put_device(&pdev->dev);
> +	return ret;
> +}
> +
> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> +{
> +	int ret, i = 0;
> +	u32 *lockstep_mode;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *nc;
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	lockstep_mode = devm_kzalloc(dev, sizeof(u32 *), GFP_KERNEL);
> +	if (!pdata || !lockstep_mode)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pdata);
> +
> +	of_property_read_u32(dev->of_node, "lockstep-mode", lockstep_mode);
> +
> +	if (!(*lockstep_mode)) {
> +		rpu_mode = PM_RPU_MODE_SPLIT;
> +	} else if (*lockstep_mode == 1) {
> +		rpu_mode = PM_RPU_MODE_LOCKSTEP;
> +	} else {
> +		dev_err(dev,
> +			"Invalid lockstep-mode mode provided - %x %d\n",
> +			*lockstep_mode, rpu_mode);
> +		return -EINVAL;
> +	}
> +	dev_dbg(dev, "RPU configuration: %s\r\n",
> +		(*lockstep_mode) ? "lockstep" : "split");
> +
> +	for_each_available_child_of_node(dev->of_node, nc) {
> +		ret = zynqmp_r5_probe(&rpus[i], pdev, nc);
> +		if (ret) {
> +			dev_err(dev, "failed to probe rpu %s.\n",
> +				of_node_full_name(nc));
> +			return ret;
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_RPROCS; i++) {
> +		struct zynqmp_r5_pdata *pdata = &rpus[i];
> +		struct rproc *rproc;
> +
> +		rproc = pdata->rproc;
> +		if (rproc) {
> +			rproc_del(rproc);
> +			rproc_free(rproc);
> +			pdata->rproc = NULL;
> +		}
> +		if (pdata->tx_chan) {
> +			mbox_free_channel(pdata->tx_chan);
> +			pdata->tx_chan = NULL;
> +		}
> +		if (pdata->rx_chan) {
> +			mbox_free_channel(pdata->rx_chan);
> +			pdata->rx_chan = NULL;
> +		}
> +
> +		device_unregister(&pdata->dev);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Match table for OF platform binding */
> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> +	{ .compatible = "xlnx,zynqmp-r5-remoteproc-1.0", },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> +
> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> +	.probe = zynqmp_r5_remoteproc_probe,
> +	.remove = zynqmp_r5_remoteproc_remove,
> +	.driver = {
> +		.name = "zynqmp_r5_remoteproc",
> +		.of_match_table = zynqmp_r5_remoteproc_match,
> +	},
> +};
> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> +
> +module_param_named(autoboot,  autoboot, bool, 0444);
> +MODULE_PARM_DESC(autoboot,
> +		 "enable | disable autoboot. (default: false)");
> +
> +MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 

Thanks,
 Michael
