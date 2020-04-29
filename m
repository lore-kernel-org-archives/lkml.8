Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4160BC83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254892068E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD2DXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:23:05 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:32962 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbgD2DXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:23:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3D253182CED28;
        Wed, 29 Apr 2020 03:23:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boy68_54e0c4c8a4616
X-Filterd-Recvd-Size: 3371
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 03:23:03 +0000 (UTC)
Message-ID: <01d45e599732bc5af33a09b36e63beabfcad8d25.camel@perches.com>
Subject: Re: [PATCH -next] hinic: Use ARRAY_SIZE for nic_vf_cmd_msg_handler
From:   Joe Perches <joe@perches.com>
To:     Zou Wei <zou_wei@huawei.com>, aviad.krawczyk@huawei.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 20:23:01 -0700
In-Reply-To: <1588130136-49236-1-git-send-email-zou_wei@huawei.com>
References: <1588130136-49236-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 11:15 +0800, Zou Wei wrote:
> fix coccinelle warning, use ARRAY_SIZE
> 
> drivers/net/ethernet/huawei/hinic/hinic_sriov.c:713:43-44: WARNING: Use ARRAY_SIZE
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_sriov.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
> index b24788e..ac12725 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
> @@ -710,8 +710,7 @@ int nic_pf_mbox_handler(void *hwdev, u16 vf_id, u8 cmd, void *buf_in,
>  	if (!hwdev)
>  		return -EFAULT;
>  
> -	cmd_number = sizeof(nic_vf_cmd_msg_handler) /
> -			    sizeof(struct vf_cmd_msg_handle);
> +	cmd_number = ARRAY_SIZE(nic_vf_cmd_msg_handler);
>  	pfhwdev = container_of(dev, struct hinic_pfhwdev, hwdev);
>  	nic_io = &dev->func_to_io;
>  	for (i = 0; i < cmd_number; i++) {

Probably better to remove cmd_number altogether
---
 drivers/net/ethernet/huawei/hinic/hinic_sriov.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
index b24788..af70cc 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
@@ -704,17 +704,15 @@ int nic_pf_mbox_handler(void *hwdev, u16 vf_id, u8 cmd, void *buf_in,
 	struct hinic_hwdev *dev = hwdev;
 	struct hinic_func_to_io *nic_io;
 	struct hinic_pfhwdev *pfhwdev;
-	u32 i, cmd_number;
+	u32 i;
 	int err = 0;
 
 	if (!hwdev)
 		return -EFAULT;
 
-	cmd_number = sizeof(nic_vf_cmd_msg_handler) /
-			    sizeof(struct vf_cmd_msg_handle);
 	pfhwdev = container_of(dev, struct hinic_pfhwdev, hwdev);
 	nic_io = &dev->func_to_io;
-	for (i = 0; i < cmd_number; i++) {
+	for (i = 0; i < ARRAY_SIZE(nic_vf_cmd_msg_handler); i++) {
 		vf_msg_handle = &nic_vf_cmd_msg_handler[i];
 		if (cmd == vf_msg_handle->cmd &&
 		    vf_msg_handle->cmd_msg_handler) {
@@ -725,7 +723,7 @@ int nic_pf_mbox_handler(void *hwdev, u16 vf_id, u8 cmd, void *buf_in,
 			break;
 		}
 	}
-	if (i == cmd_number)
+	if (i == ARRAY_SIZE(nic_vf_cmd_msg_handler))
 		err = hinic_msg_to_mgmt(&pfhwdev->pf_to_mgmt, HINIC_MOD_L2NIC,
 					cmd, buf_in, in_size, buf_out,
 					out_size, HINIC_MGMT_MSG_SYNC);


