Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B45C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299A32085B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lCm4PkpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbgEXC7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 22:59:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38982 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388262AbgEXC7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 22:59:48 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC3AF24D;
        Sun, 24 May 2020 04:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590289187;
        bh=6rGtPTsNV/JVheiq8fThWJNVnBgkyINB8EhJVHJp7m8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=lCm4PkpO4QWkReQBogq6dccITuU2metAfe2Qo+45KW7IDCsRzDSRXmYGgJ4wzVnqA
         W7iOFIeEWEJma2vwNHSbYbZezH7vyShlrr36t73igf8o3wIOAJiC6FG4lHstaNLbig
         ylFeUtgM2EBz1x/4D1k02irH35aNgl1aqnpxI2YA=
Date:   Sun, 24 May 2020 05:59:34 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>,
        Sam Ravnborg <sam@ravnborg.org>, hyun.kwon@xilinx.com,
        dri-devel@lists.freedesktop.org, sandipk@xilinx.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org, vgannava@xilinx.com
Subject: Re: [RFC PATCH 1/2] dt-bindings: display: xlnx: Add Xilinx DSI TX
 subsystem bindings
Message-ID: <20200524025934.GE6026@pendragon.ideasonboard.com>
References: <1587417656-48078-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <1587417656-48078-2-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <20200425202919.GA18024@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200425202919.GA18024@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi GVRao,

On Sat, Apr 25, 2020 at 10:29:19PM +0200, Sam Ravnborg wrote:
> On Tue, Apr 21, 2020 at 02:50:55AM +0530, Venkateshwar Rao Gannavarapu wrote:
> > This add a dt binding for Xilinx DSI TX subsystem.
> > 
> > The Xilinx MIPI DSI (Display serial interface) Transmitter Subsystem
> > implements the Mobile Industry Processor Interface (MIPI) based display
> > interface. It supports the interface with the programmable logic (FPGA).
> > 
> > Signed-off-by: Venkateshwar Rao Gannavarapu <venkateshwar.rao.gannavarapu@xilinx.com>
> > ---
> >  .../devicetree/bindings/display/xlnx/xlnx,dsi.txt  | 68 ++++++++++++++++++++++
> 
> Sorry, but new bindings in DT Schema format (.yaml) please.
> We are working on migrating all bindings to DT Schema and do not want
> to add new bindings in the old format.
> 
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt b/Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt
> > new file mode 100644
> > index 0000000..ef69729
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt
> > @@ -0,0 +1,68 @@
> > +Device-Tree bindings for Xilinx MIPI DSI Tx IP core
> > +
> > +The IP core supports transmission of video data in MIPI DSI protocol.
> > +
> > +Required properties:
> > + - compatible: Should be "xlnx-dsi".

The compatible value should start with the vendor name, followed by a
comma, and then the device identifier. This should thus be "xlnx,dsi".
However, I think calling it just "dsi" isn't specific enough, as it
could also be a DSI RX. "xlnx,dsi-tx" would be a better value. As the IP
core is versioned, I would make it "xlnx,dsi-tx-v2.0" (assuming that's
the version you want to support). If you want to support v1.0 as well,
you can add "xlnx,dsi-tx-v1.0" as an option.

> > + - reg: physical base address and length of the registers set for the device.

Does this cover both the DSI TX registers and the D-PHY registers, or
only the DSI TX registers ? It should be specified.

> > + - xlnx,dsi-num-lanes: Possible number of DSI lanes for the Tx controller.
> > +   The values should be 1, 2, 3 or 4. Based on xlnx,dsi-num-lanes and
> > +   line rate for the MIPI D-PHY core in Mbps, the AXI4-stream received by
> > +   Xilinx MIPI DSI Tx IP core adds markers as per DSI protocol and the packet
> > +   thus framed is convered to serial data by MIPI D-PHY core. Please refer
> > +   Xilinx pg238 for more details. This value should be equal to the number
> > +   of lanes supported by the connected DSI panel. Panel has to support this
> > +   value or has to be programmed to the same value that DSI Tx controller is
> > +   configured to.

The protocol configuration register has an Active Lanes field that
reports the number of lanes. Could we read the information from the
register, and drop this property ?

> > + - xlnx,dsi-datatype: Color format. The value should be one of "MIPI_DSI_FMT_RGB888",
> > +  "MIPI_DSI_FMT_RGB666", "MIPI_DSI_FMT_RGB666_PACKED" or "MIPI_DSI_FMT_RGB565".

The example below (and the driver) use "xlnx,dsi-data-type".

Same comment as above, should this be read from the Pixel Format field
instead of being specified in DT ?

> > + - #address-cells, #size-cells: should be set respectively to <1> and <0>
> > +   according to DSI host bindings (see MIPI DSI bindings [1])
> > + - clock-names: Must contain "s_axis_aclk" and "dphy_clk_200M" in same order as
> > +   clocks listed in clocks property.
> > + - clocks: List of phandles to Video and 200Mhz DPHY clocks.
> > + - port: Logical block can be used / connected independently with
> > +   external device. In the display controller port nodes, topology
> > +   for entire pipeline should be described using the DT bindings defined in
> > +   Documentation/devicetree/bindings/graph.txt.

I think you should put the "port" node in a "ports" node, as there's
also a panel subnode. Otherwise both the port and panel will compete for
#address-cells and #size-cells. It happens that both need those
properties to be 1 and 0 respectively, but isolating the two would be
cleaner.

There should also be a port for the AXI4-Stream interface. The common
practice is to number the input port@0 and the output port@1.

> > + - simple_panel: The subnode for connected panel. This represents the

This should be panel, not simple_panel.

> > +   DSI peripheral connected to the DSI host node. Please refer to
> > +   Documentation/devicetree/bindings/display/mipi-dsi-bus.txt. The
> > +   simple-panel driver has auo,b101uan01 panel timing parameters added along
> > +   with other existing panels. DSI driver derive the required Tx IP controller
> > +   timing values from the panel timing parameters.

You can drop the last two sentences, DT bindings shouldn't mention
driver-specific implementations.

> Please always use either a port or a ports node.
> 
> > +
> > +Required simple_panel properties:
> > + - compatible: Value should be one of the panel names in
> > +   Documentation/devicetree/bindings/display/panel/. e.g. "auo,b101uan01".
> > +   For available panel compatible strings, please refer to bindings in
> > +   Documentation/devicetree/bindings/display/panel/

This should be dropped too, it's out of scope.

> > +
> > +Optional properties:
> > + - xlnx,dsi-cmd-mode: denotes command mode enable.

I think this should be queried at runtime from the panel (if I'm not
mistaken it's reported through the mode_flags field of struct
mipi_dsi_device), and not specified in DT.

> > +
> > +[1]: Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
> > +[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
> > +
> > +Example:
> > +
> > +       mipi_dsi_tx_subsystem@80000000 {
> > +               compatible = "xlnx,dsi";
> > +               reg = <0x0 0x80000000 0x0 0x10000>;

DT example nodes, when using YAML, are put in a bus node that has
#address-cells and #size-cells both set to 1, so this needs to be

               reg = <0x80000000 0x10000>;

> > +               xlnx,dsi-num-lanes = <4>;
> > +               xlnx,dsi-data-type = <MIPI_DSI_FMT_RGB888>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               clock-names = "dphy_clk_200M", "s_axis_aclk";
> > +               clocks = <&misc_clk_0>, <&misc_clk_1>;
> > +               encoder_dsi_port: port@0 {
> > +                       reg = <0>;
> > +                       dsi_encoder: endpoint {
> > +                               remote-endpoint = <&xdsi_ep>;
> > +                       };
> > +               };
> > +               simple_panel: simple-panel@0 {

You can drop unused labels.

> > +                       compatible = "auo,b101uan01";
> > +                       reg = <0>;
> > +                       };

This line doesn't appear to be needed.

> > +               };

-- 
Regards,

Laurent Pinchart
