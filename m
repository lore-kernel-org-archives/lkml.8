Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55665C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CFA206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="BsH5MNun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGPIVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:21:25 -0400
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:21216
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgGPIVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyFbZXEJ5xiLPlBw0h9vWTtGEQ6hUOVHjiJHnHYPFAXeYsi/KTOIuz4jFCzCsOXZjx7HVNYNtaCgDyEZzwqVgZAPQRzCk+O4omiRhdlVW1izEHNLHPW8QgvCESnhhbZKtGswuC1nz/c/+Sa64O1B1KZzJSpbhV33faHiMrMIXOMLvEpX2kxx6xdv2apG3oYx+C7CJBWxPEaW+OOpjkRbnCArd7ty3J3uM7gYhWfDZKhbWPDLkQAxPR8eB0C+4UTaTOUUP80UHmYljpUBJ40hpQ8tn822KDs99+D/HLFsArqDEFAw1hyfQx0qRP2MYqNJ03g48H072DSnW2OaBQ70dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpONpHyOM0JnDWITYDugfAvMekZ5/v6npPMuV4WslNc=;
 b=Wb4Omt3dG581Zir78LaR2RcnkbelrofQ6uMbb8qnBWg2V9x3OU7isfdEQVFOtNyRBTGMgid7JexR9U4hlgMadb8DyOCqNFFrB/FtpKUQIPBPus1T4wUkVLxrF/74/Y46xGed1VgZ7/OGP3ftlimFHNmcYfw5DvuMqDU1lrG0e3zyTs0MMB5nbctj40laqe1F9FDdrxz9BXQncgQTRK8AV5y2/+y6T/AABkie4ki5bn6hGSBRwPvN4GP2a0VffGvQI4fdA4y/2acxT9t+6rqVy/FtwCyxa29D6rry3fZ5jTSL6QOLgR9TObz2Aqv5/EPmmbzNIUpIwh5cX56/Me/1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpONpHyOM0JnDWITYDugfAvMekZ5/v6npPMuV4WslNc=;
 b=BsH5MNunVvbtXca+fsfVhKbV/OSZS7nmhHvSPCZIw7gwSCX2gTp4jqFQ0q+eOlQnR2khRTDH7KZafFxA+FbBds4ovxPAy49wvKaxVsByY2QRCH/34ZNbIO6sjJp2PmCA8DJlfCGI/CxvR0j9SCVLcApmH3qdTjLGKPgx4IkKRNk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR0501MB2819.eurprd05.prod.outlook.com (2603:10a6:200:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 08:21:20 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 08:21:20 +0000
Date:   Thu, 16 Jul 2020 11:21:16 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH vhost next 06/10] vdpa: Add means to communicate vq
 status on get_vq_state
Message-ID: <20200716082116.GA182860@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-7-eli@mellanox.com>
 <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM3PR07CA0109.eurprd07.prod.outlook.com
 (2603:10a6:207:7::19) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM3PR07CA0109.eurprd07.prod.outlook.com (2603:10a6:207:7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 08:21:19 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5d0b02d-501b-48c1-4538-08d8296137f1
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2819:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2819DE746379BBC47DFFF80AC57F0@AM4PR0501MB2819.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHWQh4Q4DkjzOJX3QJwsVY8e6mxkIp3Z+fdZJEuENYq+I6WBsHtgT7fw7YAbBjeGRiGUhCqddSKCyGt28eSDjaM5LLPRd2CBaONfwDLUQ+7Clqkg/SgX8DEEKAFlZ770Dux4f46BCi0xqnQznYJVoepvhYZ2vf220/4ashXqeaqFe3z/q6Jt+4fQr76IKwOnn1cvHrKryusLqEoCvbQDQ4mo+WLQuMNwWXgTsEO79FSi5R9tvUu3dFMReqfypiVsM581c1ekbhsnopsNk38vFgozaFFnrJedrdavVUn6D4E48sWXk1ZtrnydSH+dZOMBD3F4FmkgnEwc27wg7dSyXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(66946007)(7696005)(186003)(26005)(107886003)(86362001)(4326008)(478600001)(55016002)(956004)(1076003)(9686003)(2906002)(66476007)(16526019)(5660300002)(66556008)(52116002)(6666004)(8676002)(83380400001)(33656002)(6506007)(316002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7gYV3wkHB7fV7G8xAu+x2Eq39FojfS2ZVjKfXokmTjAPrX5Z9ZICsb+b3wXLRMyJ9E82Vw9lEWqUmh5WxtDod5bvBvo/moC9xRKFNGZ05fxSFyVpcQAWtE0yUPrTMcC5RG2SmfVaGEHkhXr2K70cujPO0RpgACpVPA/XaznTDJ5rNK0GI9ZRfMuLvjm7E8gIEzZNRL8qGc3yrVYIK6tuEOpwLIVJRIwnDq86eBUOZB2qb2o801BsiFAj5DkmECK5rAYa4AGEZ/oJeIOhHWYtsaPh6jNubLibwjs6kHzQkAnMbxR9Ba5TN8XfU88Q+A8Z7xUza5na9COle5Rxr9l14wY5UrBOscJwS92Je0TSAaXfh8sbfvScvq1owdCQAbeMPv3XEvx+uQ7hO6IU20fL4W5NsI9WuXz5TAX7xp8gj3WRhlXS2MP8r/cSOQl5JjHEZ4UWiZIVblsGBfRWQdK1esW/lqzS/B1xve/X/LUSQ4g=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d0b02d-501b-48c1-4538-08d8296137f1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 08:21:20.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWPPJiqQd5muczQUluNzrWYmElOBwMw1zlRO49rSfeIgIMzqLu5dALeoIp3MgwS2ZnubtmbpS36ZwQA5t5sCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:11:00PM +0800, Jason Wang wrote:
> 
> On 2020/7/16 下午3:23, Eli Cohen wrote:
> >Currently, get_vq_state() is used only to pass the available index value
> >of a vq. Extend the struct to return status on the VQ to the caller.
> >For now, define VQ_STATE_NOT_READY. In the future it will be extended to
> >include other infomration.
> >
> >Modify current vdpa driver to update this field.
> >
> >Reviewed-by: Parav Pandit <parav@mellanox.com>
> >Signed-off-by: Eli Cohen <eli@mellanox.com>
> 
> 
> What's the difference between this and get_vq_ready()?
> 
> Thanks
> 

There is no difference. It is just a way to communicate a problem to
with the state of the VQ back to the caller. This is not available now.
I think an asynchronous is preferred but that is not available
currently.
> 
> >---
> >  drivers/vdpa/ifcvf/ifcvf_main.c  | 1 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
> >  include/linux/vdpa.h             | 9 +++++++++
> >  3 files changed, 11 insertions(+)
> >
> >diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> >index 69032ee97824..77e3b3d91167 100644
> >--- a/drivers/vdpa/ifcvf/ifcvf_main.c
> >+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> >@@ -240,6 +240,7 @@ static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> >  {
> >  	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> >+	state->state = vf->vring[qid].ready ? 0 : BIT(VQ_STATE_NOT_READY);
> >  	state->avail_index = ifcvf_get_vq_state(vf, qid);
> >  }
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >index 599519039f8d..06d974b4bd7b 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >@@ -434,6 +434,7 @@ static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >  	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> >  	struct vringh *vrh = &vq->vring;
> >+	state->state = vq->ready ? 0 : BIT(VQ_STATE_NOT_READY);
> >  	state->avail_index = vrh->last_avail_idx;
> >  }
> >diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >index 7b088bebffe8..bcefa30a3b2f 100644
> >--- a/include/linux/vdpa.h
> >+++ b/include/linux/vdpa.h
> >@@ -27,12 +27,21 @@ struct vdpa_notification_area {
> >  	resource_size_t size;
> >  };
> >+/**
> >+ * Bitmask describing the status of the vq
> >+ */
> >+enum {
> >+	VQ_STATE_NOT_READY = 0,
> >+};
> >+
> >  /**
> >   * vDPA vq_state definition
> >   * @avail_index: available index
> >+ * @state: returned status from get_vq_state
> >   */
> >  struct vdpa_vq_state {
> >  	u16	avail_index;
> >+	u32	state;
> >  };
> >  /**
> 
