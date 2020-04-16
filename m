Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B463C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D742076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkQrqoYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404267AbgDPQ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:57:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731440AbgDPQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587056215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtqJ90xdaaArC4Wt+UP95sE7yqWa9iDJbaqMvVSt4X0=;
        b=LkQrqoYcaEYmuVF370CzpuhcxLqCF7zoNQKvZBcyWvsqzGpsHObMjLg2yy1c1DrZPAOtnP
        UtUom9dc8sK0Hl/EAdpYYT6Arby750KGLGbIWkYyC9c7Na9ycdhAkrrwTHcDJlsxAR5K0F
        qtFVJ6QnfR3AaHka4wDPNmcErcG+j1g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-f_Z4ST6tMpeoWKrcgAAWOQ-1; Thu, 16 Apr 2020 12:56:51 -0400
X-MC-Unique: f_Z4ST6tMpeoWKrcgAAWOQ-1
Received: by mail-qv1-f72.google.com with SMTP id t16so3856867qve.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FtqJ90xdaaArC4Wt+UP95sE7yqWa9iDJbaqMvVSt4X0=;
        b=LPNFMEXRu+f4l34W873RVypKAWPVteqllPgEzmwyMNVR7q4o55aJzJ1qpVtNMAQhi5
         gkc/KN6Nke0CDma5sfiXjwRf6/sCR6ySIbu4XUv/iA6XoOqoHIu04WDCTr8BxINT4OYp
         xIF6vpucm8E9dG3/qDJ3pUIdeyEtjVyYwR37ZchXyTfdNeNhCNEpPRUC8ieUZXK+1BZt
         H690E+oq0ZuYUbtw/XtEQ8hK8ZqYmao+F2YAGI5wLKzrRT8dLCTjk77hvZ6DpXcuEsFe
         IMJA8kYfpGOkLU6aLd7NTBN2715ZNIjfbL8r8urbzonQ48JjqX/TEJ7RzC5vuAoHXxp7
         WfNg==
X-Gm-Message-State: AGi0Pub7PRKFdcavl5HYvFxEuMmoxfKbHsH1wUkXty6s9bNNXbWxMB5a
        26+kp7Dc0bEwSN6Gui9eKcaNFSkIhnGz15ElSUX5FD//tsxlx3fFkc6CmJFHVpi0UEhZugNkapD
        mXJyY2Hm3lcNWcMpBdenXiy+Y
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr22103004qkm.272.1587056211050;
        Thu, 16 Apr 2020 09:56:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypISGwMhzI4XgAte4arKs5cwA/hMNtaSO2/TYLJCXRGvthdsD3ysU+JITN4tZMZtQ4vVgyLw6A==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr22102984qkm.272.1587056210851;
        Thu, 16 Apr 2020 09:56:50 -0700 (PDT)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c33sm11855109qtb.76.2020.04.16.09.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:56:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "bhu@redhat.com" <bhu@redhat.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
Date:   Thu, 16 Apr 2020 09:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check the scope.

On linus/master, the result of this change looks like

static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
{
    struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
    struct dfl_fpga_cdev *cdev = drvdata->cdev;

    if (!num_vfs) {
        /*
         * disable SRIOV and then put released ports back to default
         * PF access mode.
         */
        pci_disable_sriov(pcidev);

        dfl_fpga_cdev_config_ports_pf(cdev);

    } else {
        int ret; <--- defined here

        /*
         * before enable SRIOV, put released ports into VF access mode
         * first of all.
         */
        ret = dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
        if (ret)
            return ret;

        ret = pci_enable_sriov(pcidev, num_vfs);
        if (ret)
            dfl_fpga_cdev_config_ports_pf(cdev);
    }

    return ret;  <---- not in scope, not defined here
}

Tom

