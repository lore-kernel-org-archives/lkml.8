Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDDC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C58A206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587493293;
	bh=ATBwv0eRgaZeNwgo+oME9DnGsnaEirIUiV8DuGe4/cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WTBm8biOly5zPJGsTucsDY5tfn9Gzo63h/D+5mlcf2r5keipT0ZbW+bzpyZi8/0ka
	 6buAkNcWQU1Lcdz9MYMYHdMVO8t7PlL6dWpJKf+cZFK5z+5TL5pGH0kSzZrk9D6v3E
	 Sj5A9biVHdR6Bf+Z43lHzNrkjSf0KYOMsNYCPUwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgDUSVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUSVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:21:32 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BD120679;
        Tue, 21 Apr 2020 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587493291;
        bh=ATBwv0eRgaZeNwgo+oME9DnGsnaEirIUiV8DuGe4/cs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iTmzR/w75j8lp5sIM7s4J086c1Ss9oGQyXjzlZWaJi++mlNabE1Hap5G1gduBAIf2
         aesV7W27+398LjISvWR1BmOdKkvzXKInatgtsGIigNo34Q6xErx19CXn057CmXoH9J
         youeXwHUpYQT8Ctl+MqJn+FXBUMv/eh6r4hyT+68=
Date:   Tue, 21 Apr 2020 11:21:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next 2/3] hinic: add sriov feature support
Message-ID: <20200421112121.2f0ddf30@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200421045635.8128-3-luobin9@huawei.com>
References: <20200421045635.8128-1-luobin9@huawei.com>
        <20200421045635.8128-3-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 04:56:34 +0000 Luo bin wrote:
> +int hinic_pci_sriov_disable(struct pci_dev *pdev)
> +{
> +	struct hinic_sriov_info *sriov_info;
> +	u16 tmp_vfs;
> +
> +	sriov_info = hinic_get_sriov_info_by_pcidev(pdev);
> +	/* if SR-IOV is already disabled then nothing will be done */
> +	if (!sriov_info->sriov_enabled)
> +		return 0;

Can't happen see below.

> +	if (test_and_set_bit(HINIC_SRIOV_DISABLE, &sriov_info->state)) {
> +		dev_err(&pdev->dev,
> +			"SR-IOV disable in process, please wait");
> +		return -EPERM;
> +	}

Hm. I don't understand why you need these bit locks.

> +	/* If our VFs are assigned we cannot shut down SR-IOV
> +	 * without causing issues, so just leave the hardware
> +	 * available but disabled
> +	 */
> +	if (pci_vfs_assigned(sriov_info->pdev)) {
> +		clear_bit(HINIC_SRIOV_DISABLE, &sriov_info->state);
> +		dev_warn(&pdev->dev, "Unloading driver while VFs are assigned - VFs will not be deallocated\n");
> +		return -EPERM;
> +	}
> +	sriov_info->sriov_enabled = false;
> +
> +	/* disable iov and allow time for transactions to clear */
> +	pci_disable_sriov(sriov_info->pdev);
> +
> +	tmp_vfs = (u16)sriov_info->num_vfs;
> +	sriov_info->num_vfs = 0;
> +	hinic_deinit_vf_hw(sriov_info, OS_VF_ID_TO_HW(0),
> +			   OS_VF_ID_TO_HW(tmp_vfs - 1));
> +
> +	clear_bit(HINIC_SRIOV_DISABLE, &sriov_info->state);
> +
> +	return 0;
> +}
> +
> +int hinic_pci_sriov_enable(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct hinic_sriov_info *sriov_info;
> +	int pre_existing_vfs = 0;
> +	int err = 0;
> +
> +	sriov_info = hinic_get_sriov_info_by_pcidev(pdev);
> +
> +	if (test_and_set_bit(HINIC_SRIOV_ENABLE, &sriov_info->state)) {
> +		dev_err(&pdev->dev,
> +			"SR-IOV enable in process, please wait, num_vfs %d\n",
> +			num_vfs);
> +		return -EPERM;
> +	}

This should never happen, PCI core code will prevent SR-IOV from being
enabled twice in a row, and concurrently. See sriov_numvfs_store().

> +	pre_existing_vfs = pci_num_vf(sriov_info->pdev);
> +
> +	if (num_vfs > pci_sriov_get_totalvfs(sriov_info->pdev)) {
> +		clear_bit(HINIC_SRIOV_ENABLE, &sriov_info->state);
> +		return -ERANGE;
> +	}

Again, can't happen.

> +	if (pre_existing_vfs && pre_existing_vfs != num_vfs) {
> +		err = hinic_pci_sriov_disable(sriov_info->pdev);
> +		if (err) {
> +			clear_bit(HINIC_SRIOV_ENABLE, &sriov_info->state);
> +			return err;
> +		}

And this.

> +	} else if (pre_existing_vfs == num_vfs) {

Or this.

> +		clear_bit(HINIC_SRIOV_ENABLE, &sriov_info->state);
> +		return num_vfs;
> +	}
> +
> +	err = pci_enable_sriov(sriov_info->pdev, num_vfs);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Failed to enable SR-IOV, error %d\n", err);
> +		clear_bit(HINIC_SRIOV_ENABLE, &sriov_info->state);
> +		return err;
> +	}
> +
> +	sriov_info->sriov_enabled = true;
> +	sriov_info->num_vfs = num_vfs;
> +	clear_bit(HINIC_SRIOV_ENABLE, &sriov_info->state);
> +
> +	return num_vfs;
> +}
> +
> +int hinic_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
> +{
> +	struct hinic_sriov_info *sriov_info;
> +
> +	sriov_info = hinic_get_sriov_info_by_pcidev(dev);
> +
> +	if (test_bit(HINIC_FUNC_REMOVE, &sriov_info->state))
> +		return -EFAULT;

I don't think EFAULT is not a correct error code here. Use EBUSY, or
ENODEV?

> +	if (!num_vfs)
> +		return hinic_pci_sriov_disable(dev);
> +	else
> +		return hinic_pci_sriov_enable(dev, num_vfs);
> +}
