Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0936C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8819F20747
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="esH6rqnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFOArO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:47:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50796 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgFOArM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:47:12 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200615004710epoutp01a5fe605fa3b5396c4308de07dd407e7a~YkR7wNyLm3275532755epoutp01P
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:47:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200615004710epoutp01a5fe605fa3b5396c4308de07dd407e7a~YkR7wNyLm3275532755epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592182030;
        bh=8yvh7hV29VBPOtwpd8omf9HSfJ9mL6MVoGzHXyVkzKM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=esH6rqnU5jYdTX5AMWLAWhUhL7EiD6t3Dpgp+lHTSC/obSercnAWweMRF9qGob+kC
         SFhnNY7O+wM80uAAv5ZCYdJucS14BpV+VnTRCyJjShTfL3bPpw40r3LYE781oJTuqH
         b2FL9ZgYsSociYXPV6zUCqRXh3fiyuG/nLxi7VTo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200615004709epcas1p365ad9f2a41c4f8ef2c2201f7784524c0~YkR63vdTd3045330453epcas1p3N;
        Mon, 15 Jun 2020 00:47:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49lXj770DwzMqYkn; Mon, 15 Jun
        2020 00:47:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.CE.18978.B05C6EE5; Mon, 15 Jun 2020 09:47:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200615004707epcas1p3f9d0e4367d2a8f333961a05fee14258a~YkR44ko1e3059930599epcas1p37;
        Mon, 15 Jun 2020 00:47:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200615004707epsmtrp1f86ef955f5aee69b793717dd0083138a~YkR43o9NU2192121921epsmtrp1c;
        Mon, 15 Jun 2020 00:47:07 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-73-5ee6c50b2ab6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.83.08382.B05C6EE5; Mon, 15 Jun 2020 09:47:07 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200615004707epsmtip1aa43a233efc06f0cb1b7365c311ad051~YkR4qpdgL1601216012epsmtip1G;
        Mon, 15 Jun 2020 00:47:06 +0000 (GMT)
Subject: Re: [PATCH] drm/exynos: fix ref count leak in mic_pre_enable
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <027d9eb5-a1c1-c329-72c3-a555b71f8677@samsung.com>
Date:   Mon, 15 Jun 2020 09:52:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200614062339.87374-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmri730WdxBs/mm1v0njvJZPF/20Rm
        iytf37NZPGuczmrx4t5FFov+x6+ZLU7MO8tucf78BnaLs01v2C02Pb7GanF51xw2ixnn9zFZ
        9J7cwWwx7csidosZk1+yWfQebWRzEPDY+20Bi8fOWXfZPTat6mTz2P7tAavH/e7jTB6bl9R7
        9G1ZxehxdWETu8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL
        89L1kvNzrQwNDIxMgQoTsjN2ntvHXLCYo6Lz5hbmBsaHbF2MHBwSAiYSLb9luxi5OIQEdjBK
        PDnyhhXC+cQo0fXlCguE841R4vbdCUAZTrCO7W/eM0Mk9jJKTF7wBqrqPaPE2a3tLCBVwgKu
        Ek9+XgdLiAicYJZYcO4F2EJmATeJJydEQGrYBFQlJq64zwZi8wrYSazd8xWslwUo/qLnLwtI
        uahAhMTpr4kQJYISJ2c+ASvhFLCXaJuxhBnEZhYQl7j1ZD4ThC0v0bx1NthxEgIvOCTudT1g
        h7jaReJhx1aoD4QlXh3fAhWXknjZ38YO0dDMKDFxxmkmCKeDUeLu4+ssEFXGEvuXTmaCeEBT
        Yv0ufYiwosTO33MZITbzSbz72sMKCVReiY42IYgSJYljF28wQtgSEheWTGSDsD0kjvzuZp/A
        qDgLyW+zkPwzC8k/sxAWL2BkWcUollpQnJueWmxYYIgc25sYwUlcy3QH48S3H/QOMTJxMB5i
        lOBgVhLh7U57EifEm5JYWZValB9fVJqTWnyI0RQY2BOZpUST84F5JK8k3tDUyNjY2MLE0MzU
        0FBJnFdc5kKckEB6YklqdmpqQWoRTB8TB6dUA1N5AZvHKpO96x49DbgS7mxraL3ur2OM6rcv
        fxZEH3Tc29sSdyNkHuvJeX2fZK5YzhRIdzm7Wanx4PtJxmcOHUm6nVytnbjr74+Np6J2TDqR
        kr3XIlQyct2/L3PDT5zXkJnme3zFt7opTksLl/79J8xtNFfUffm/oiz/O/dmL/485UHEo1bD
        TdeurEtuu6brsEH1zGPb9TomL0584P+hZ7/D/MKJXa/v9PUJ8Nfb2GxLZ35X8TKf4b3zCe7C
        it17lq452vqwwPbPvlUsjVO2pk2IP2nSJCB554Tro3lp+ys/LJ4QW6ZqrCpQct10Ss/qfxNN
        OxelNUyMPbk1eVrU47XnOKL8c+YcniWRuu/0qYaVV5RYijMSDbWYi4oTAY0a+iJrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnC730WdxBisfcFv0njvJZPF/20Rm
        iytf37NZPGuczmrx4t5FFov+x6+ZLU7MO8tucf78BnaLs01v2C02Pb7GanF51xw2ixnn9zFZ
        9J7cwWwx7csidosZk1+yWfQebWRzEPDY+20Bi8fOWXfZPTat6mTz2P7tAavH/e7jTB6bl9R7
        9G1ZxehxdWETu8fnTXIBnFFcNimpOZllqUX6dglcGTvP7WMuWMxR0XlzC3MD40O2LkZODgkB
        E4ntb94zdzFycQgJ7GaUOLXiPVCCAyghIbFlKweEKSxx+HAxRMlbRokjd3eD9QoLuEo8+Xmd
        BSQhInCKWWLb9idMIA3MAm4ST06IQDRMYpT48LmHBaSBTUBVYuKK+2DNvAJ2Emv3fAWLswDF
        X/T8BbNFBSIknm+/wQhRIyhxcuYTsDingL1E24wlzCA2s4C6xJ95l6BscYlbT+YzQdjyEs1b
        ZzNPYBSahaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhq
        tTR3MG5f9UHvECMTB+MhRgkOZiUR3u60J3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowT
        EkhPLEnNTk0tSC2CyTJxcEo1MB1+teTKck+Jo9unX7K+fa+U2bH79N9aG/MDH0z0LniIGgp3
        nQjs3/H/sXaIcYgazwrxzxubRKTPM8V6ndK2mrxB7vmsk7bvXDdwnv3+/na14WOJe7PUa2ev
        nvw4ecelloeqirIPQ/e+CHzQwa2lLbZizowvF5eftpp8+n7+RP6rb1yallSUS3I4Radvjt3x
        T/Yoawif1xbuxW2S/R6sJQtXcEZy1jyOlnmkEWLT6zjXl2+KQubByAOVrumWZtZS/t/mrUxJ
        clvkJTTBvHml9Xfu5hsyXzf2TXm3IHPH1+uepXOdp4g952l7fvyD71W9/Cd7/qyNnBbpPln6
        1oW+hp2upj/zpPxVa0KnF7mvmqzEUpyRaKjFXFScCAAU6wGESQMAAA==
X-CMS-MailID: 20200615004707epcas1p3f9d0e4367d2a8f333961a05fee14258a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200614062349epcas1p1e285479c1e6483708b62f93e70a453a4
References: <CGME20200614062349epcas1p1e285479c1e6483708b62f93e70a453a4@epcas1p1.samsung.com>
        <20200614062339.87374-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

20. 6. 14. 오후 3:23에 Navid Emamdoost 이(가) 쓴 글:
> in mic_pre_enable, pm_runtime_get_sync is called which
> increments the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_mic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
> index a86abc173605..69ff74c2ceb5 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
> @@ -270,7 +270,7 @@ static void mic_pre_enable(struct drm_bridge *bridge)
>  
>  	ret = pm_runtime_get_sync(mic->dev);
>  	if (ret < 0)
> -		goto unlock;
> +		goto turn_off;

How about just calling pm_runtime_put_noidle()?

if (ret < 0) {
	pm_runtime_put_noidle(mic->dev);
	goto unlock;
}

Thanks,
Inki Dae

>  
>  	mic_set_path(mic, 1);
>  
> 
