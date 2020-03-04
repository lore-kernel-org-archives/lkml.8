Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B250C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE76120732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m/BfncmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbgCDMBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:01:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44418 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:01:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 024C1QT5059394;
        Wed, 4 Mar 2020 06:01:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583323286;
        bh=qmSDebbg1BWjoHoTvzc2bbmCZ4PfTbx0tskdmETuTFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=m/BfncmVQYsGwnq5dJ2EipLlrXchzC1v+I2GjFeW3lG18IY4MFDeLv+6r5mEWd6U4
         q5QDhIe3NW5UnNh0Ngsiqi9XVELouVZycOGDPWh3SrLbQXhqNhAySyl84qfAr0+gv3
         47qe20tz9kAVUVEv9LSHf7Egd7+dQT8QE7/fxt9w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 024C1QMo041834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Mar 2020 06:01:26 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 06:01:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 06:01:25 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 024C1MZP106164;
        Wed, 4 Mar 2020 06:01:23 -0600
Subject: Re: [PATCH v4 00/13] PHY: Update Cadence Torrent PHY driver with
 reconfiguration
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f9dc8d82-0a61-62c2-c0b4-2f301ef9b949@ti.com>
Date:   Wed, 4 Mar 2020 17:35:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/20 11:40 am, Yuti Amonkar wrote:
> This patch series applies to the Cadence SD0801 PHY driver.
> Cadence SD0801 PHY is also known as Torrent PHY. Torrent PHY
> is a multiprotocol PHY supporting PHY configurations including
> Display Port, USB and PCIe.
> 
> This patch series converts SD0801 PHY driver for DisplayPort into a
> generic Torrent PHY driver, updates DisplayPort functionality with
> reconfiguration support and finally adds platform dependent initialization
> for TI J7 SoCs.

merged now, Thanks!

-Kishon
> 
> The patch series has following patches which applies the changes
> in the below sequence
> 1. 001-dt-bindings-phy-Remove-Cadence-MHDP-PHY-dt-binding
> This patch removes the MHDP PHY binding.
> 2. 002-dt-bindings-phy-Add-Cadence-MHDP-PHY-bindings-in-YAML-format.
> This patch converts the MHDP PHY device tree bindings to yaml schemas
> 3. 003-phy-cadence-dp-Rename-to-phy-Cadence-Torrent
> Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
> 4. 004-phy-cadence-torrent-Adopt-Torrent-nomenclature
> Update private data structures, module descriptions and functions prefix to Torrent
> 5. 005-phy-cadence-torrent-Add-wrapper-for-PHY-register-access
> Add a wrapper function to write Torrent PHY registers to improve code readability.
> 6. 006-phy-cadence-torrent-Add-wrapper-for-DPTX-register-access
> Add wrapper functions to read, write DisplayPort specific PHY registers to improve code
> readability.
> 7. 007-phy-cadence-torrent-Refactor-code-for-reusability
> Add separate function to set different power state values.
> Use of uniform polling timeout value. Check return values of functions for error handling.
> 8. 008-phy-cadence-torrent-Add-19.2-MHz-reference-clock-support
> Add configuration functions for 19.2 MHz reference clock support. Add register configurations
> for SSC support.
> 9. 009-phy-cadence-torrent-Implement-phy-configure-APIs
> Add PHY configuration APIs for link rate, number of lanes, voltage swing and pre-emphasis values.
> 10. 010-phy-cadence-torrent-Use-regmap-to-read-and-write-Torrent-PHY-registers 
> Use regmap for accessing Torrent PHY registers. Update register offsets. Abstract address
> calculation using regmap APIs.
> 11. 011-phy: cadence-torrent-Use-regmap-to-read-and-write-DPTX-PHY-registers
> Use regmap to read and write DPTX specific PHY registers.
> 12. 012-phy-cadence-torrent-Add-platform-dependent-initialization-structure
> Add platform dependent initialization data for Torrent PHY used in TI's J721E SoC.
> 13. 013-phy: cadence-torrent-Add-support-for-subnode-bindings
> Implement single link subnode support to the phy driver.
> 
> Version History:
> 
> v4:
> - Add separate patch to remove old binding.
> - Add new patch to add new binding in YAML format.
> - Squashed "dt-bindings: phy: phy-cadence-torrent: Add platform dependent
>   compatible string" with "dt-bindings: phy: Add Cadence MHDP PHY bindings
>   in YAML format".
> - Added SPDX dual license tag to YAML bindings.
> - Updated resets property description and removed reset-names
>   property.
> - Added enum to cdns,phy-type property adding all the currently
>   known phy-type values.
> - Updated the child node resets property to support one reset
>   per lane.
> - Added default values for cdns,num-lanes and cdns,max-bit-rate properties.
> 
> 
> v3:
> - Removed "Add clock binding" patch from the series and merged it with
>   "Convert-Cadence-MHDP-PHY-bindings-to-YAML" patch.
> - Added reset and reset-names properties to YAML file.
> - Updated dptx_phy reg entry as optional in YAML.
> - Renamed reg-names from sd0801_phy to torrent_phy.
> - Added subnode property for each group of PHY lanes based on PHY
>   type to the YAML. Renamed num_lanes and max_bit_rate to cdns,num-lanes
>   and cdns,max-bit-rate and moved it to subnode properties.
> - Added cdns,phy-type property in subnode. Currently cdns,phy-type supports only
>   PHY_TYPE_DP.
> - Added subnode instance structure to the driver in reference to the dts change.
> - Updated functions to read properties from child node instead of parent node.
> - Added num_lanes as argument to the cdns_torrent_dp_run function.
> 
> v2:
> - Remove patch [1] from this series and send for a separate review.
> - Use enum in compatible property of YAML file.
> - Remove quotes in clock-names property "refclk" -> refclk in YAML file.
> - Add reg-names property to YAML file
> - Add additionalProperties:false to YAML file.
> - No change in the driver code.
> 
> This patch series is dependent on PHY DisplayPort configuration patch [1].
> 
> [1]
> 
> https://lkml.org/lkml/2020/1/6/279
> 
> Swapnil Jakhade (10):
>   phy: cadence-torrent: Adopt Torrent nomenclature
>   phy: cadence-torrent: Add wrapper for PHY register access
>   phy: cadence-torrent: Add wrapper for DPTX register access
>   phy: cadence-torrent: Refactor code for reusability
>   phy: cadence-torrent: Add 19.2 MHz reference clock support
>   phy: cadence-torrent: Implement PHY configure APIs
>   phy: cadence-torrent: Use regmap to read and write Torrent PHY
>     registers
>   phy: cadence-torrent: Use regmap to read and write DPTX PHY registers
>   phy: cadence-torrent: Add platform dependent initialization structure
>   phy: cadence-torrent: Add support for subnode bindings
> 
> Yuti Amonkar (3):
>   dt-bindings: phy: Remove Cadence MHDP PHY dt binding
>   dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.
>   phy: cadence-dp: Rename to phy-cadence-torrent
> 
>  .../bindings/phy/phy-cadence-dp.txt           |   30 -
>  .../bindings/phy/phy-cadence-torrent.yaml     |  143 ++
>  drivers/phy/cadence/Kconfig                   |    6 +-
>  drivers/phy/cadence/Makefile                  |    2 +-
>  drivers/phy/cadence/phy-cadence-dp.c          |  541 -----
>  drivers/phy/cadence/phy-cadence-torrent.c     | 1944 +++++++++++++++++
>  6 files changed, 2091 insertions(+), 575 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>  delete mode 100644 drivers/phy/cadence/phy-cadence-dp.c
>  create mode 100644 drivers/phy/cadence/phy-cadence-torrent.c
> 
